#!/bin/bash
set -euo pipefail

SPARSE_REPO_NAME="products.aspose.cloud"

# Go to sparse-repo directory
pushd "$(dirname "$0")/../sparse-repo/"

# Check if the repository already exists
if [ ! -d "${SPARSE_REPO_NAME}" ]; then
  echo "Cloning sparse repository..."
  git clone --depth 1 --filter=blob:none --sparse git@github.com:aspose-cloud/products.aspose.cloud.git "${SPARSE_REPO_NAME}"
  pushd "${SPARSE_REPO_NAME}"
  # Switch sparse-checkout to non-cone mode (needed for single files)
  git sparse-checkout init --no-cone
  # Enable sparse checkout for all except heavy dir with /content/
  # And also add "/content/barcode/"
  git sparse-checkout set \
    $(git ls-tree --name-only HEAD | grep -v '^content$') \
    content/barcode/ \
    content/_index.md
else
  echo "${SPARSE_REPO_NAME} repository already exists."
  pushd "${SPARSE_REPO_NAME}"
  echo "Pulling latest changes..."
  git pull
fi
# echo "Sparse checkout includes:"
# git sparse-checkout list
# You are in a sparse checkout with 1% of tracked files present.

# Copy /static/ and /data/ content from sparse repo to main site
# Hugo does not support symlinks for this
echo "copying to /static/ ..."
cp -r static/* ../../static/
echo "copying to /data/ ..."
cp -r data/* ../../data/

popd
popd
