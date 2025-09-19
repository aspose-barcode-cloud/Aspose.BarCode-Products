#!/bin/bash
set -euo pipefail

# Go to submodules directory
pushd "$(dirname "$0")/../submodules/"

# Check if the repository already exists
if [ ! -d "products.aspose.cloud" ]; then
  echo "Cloning sparse repository..."
  git clone --depth 1 --filter=blob:none --sparse git@github.com:aspose-cloud/products.aspose.cloud.git
  pushd "products.aspose.cloud"
  # Switch sparse-checkout to non-cone mode (needed for single files)
  git sparse-checkout init --no-cone
  # Enable sparse checkout for all except heavy dir with /content/
  # And also add "/content/barcode/"
  git sparse-checkout set \
    $(git ls-tree --name-only HEAD | grep -v '^content$') \
    /content/barcode/
else
  echo "products.aspose.cloud repository already exists."
  pushd "products.aspose.cloud"
  echo "Pulling latest changes..."
  git pull
fi
# echo "Sparse checkout includes:"
# git sparse-checkout list
# You are in a sparse checkout with 1% of tracked files present.

# Copy static and data content from submodule to main site
# Hugo does not support symlinks for this
cp -r static/* ../../static/
cp -r data/* ../../data/

popd
popd
