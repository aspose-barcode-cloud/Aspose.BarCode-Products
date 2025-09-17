#!/bin/bash
set -euo pipefail

HUGO_CONTENT_DIR="./barcode"

HUGO_CONFIG="./submodules/products.aspose.cloud/config-prod.toml"
HUGO_THEMES_DIR="./submodules/products.aspose.cloud/themes/"


# Go to content directory
pushd "$(dirname "$0")/.."

# See https://github.com/aspose-cloud/products.aspose.cloud-workflows/blob/main/.github/workflows/barcode-production.yml
hugo server \
  --baseURL="https://products.aspose.cloud/barcode" \
  --bind "127.0.0.1" \
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
  --port 1313 \
  --themesDir "${HUGO_THEMES_DIR}" \
  --verbose \
  --watch

popd
