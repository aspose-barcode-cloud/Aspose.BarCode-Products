#!/bin/bash
set -euo pipefail

# Go to submodules directory
pushd "$(dirname "$0")/../submodules/"

git clone --depth 1 --filter=blob:none --sparse git@github.com:aspose-cloud/products.aspose.cloud.git || true

# CD into the cloned repository
cd products.aspose.cloud

# Switch sparse-checkout to non-cone mode (needed for single files)
git sparse-checkout init --no-cone

# Enable sparse checkout for just your directory and files by pattern config-prod.toml
git sparse-checkout set themes/lutsk-aspose-theme-sdks-aspose-cloud/ config-prod.toml

git sparse-checkout list

# You are in a sparse checkout with 1% of tracked files present.

git pull

popd
