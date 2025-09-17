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
  # Enable sparse checkout for just your directory and files by pattern config-prod.toml
  git sparse-checkout set \
    archetypes/ \
    assets/ \
    data/ \
    static/ \
    themes/lutsk-aspose-theme-sdks-aspose-cloud/ \
    config-prod.toml
else
  echo "products.aspose.cloud repository already exists."
  pushd "products.aspose.cloud"
  echo "Pulling latest changes..."
  git pull
fi

echo "Sparse checkout includes:"
git sparse-checkout list

# You are in a sparse checkout with 1% of tracked files present.

popd
popd
