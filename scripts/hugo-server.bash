#!/bin/bash
set -euo pipefail

HUGO_CONTENT_DIR="content"

HUGO_CONFIG="./submodules/products.aspose.cloud/config-prod.toml"
HUGO_THEMES_DIR="./submodules/products.aspose.cloud/themes/"

HUGO_BASE_URL="https://aspose.test"

# Go to content directory
pushd "$(dirname "$0")/.."

# See https://github.com/aspose-cloud/products.aspose.cloud-workflows/blob/main/.github/workflows/barcode-production.yml
echo "Building site with Hugo..."
hugo \
  --baseURL="${HUGO_BASE_URL}" \
  --cleanDestinationDir \
  --config "${HUGO_CONFIG}" \
  --contentDir "${HUGO_CONTENT_DIR}" \
  --ignoreCache \
  --themesDir "${HUGO_THEMES_DIR}" \
  --verbose

echo "Starting Hugo server..."
hugo server \
  --baseURL="${HUGO_BASE_URL}" \
  --bind "127.0.0.1" \
  --port 1313 \
  --buildDrafts \
  --buildExpired \
  --buildFuture \
  --cleanDestinationDir \
  --config "${HUGO_CONFIG}" \
  --contentDir "${HUGO_CONTENT_DIR}" \
  --debug \
  --disableFastRender \
  --gc \
  --ignoreCache \
  --themesDir "${HUGO_THEMES_DIR}" \
  --verbose \
  --watch

popd
