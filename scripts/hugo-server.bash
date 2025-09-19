#!/bin/bash
set -euo pipefail

HUGO_CONTENT_DIR="content"

# HUGO_CONFIG="./submodules/products.aspose.cloud/config-prod.toml"
HUGO_CONFIG="./config-prod.toml"
# HUGO_THEMES_DIR="./submodules/products.aspose.cloud/themes/"
HUGO_THEMES_DIR="./themes/"

# HUGO_BASE_URL="https://aspose.test"
HUGO_BASE_URL="https://products.aspose.cloud"
FILE_TO_CHECK="public/barcode/index.html"

# Go to content directory
pushd "$(dirname "$0")/.."

# See https://github.com/aspose-cloud/products.aspose.cloud-workflows/blob/main/.github/workflows/barcode-production.yml
./scripts/change-urls.bash "${HUGO_CONTENT_DIR}"

echo "Building site with Hugo..."
hugo \
  --config "${HUGO_CONFIG}" \
  --contentDir "${HUGO_CONTENT_DIR}" \
  --baseURL="${HUGO_BASE_URL}" \
  --cleanDestinationDir \
  --themesDir "${HUGO_THEMES_DIR}" \
  --minify \
  --clock "2025-09-19T12:00:00Z"

echo
echo "Checking generated site in public/ ..."
if [ -f "${FILE_TO_CHECK}" ]; then
  echo "OK file ${FILE_TO_CHECK} exists."
  echo
else
  echo "Error: ${FILE_TO_CHECK} does not exist!"
  exit 1
fi

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
