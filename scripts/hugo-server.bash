#!/bin/bash
set -euo pipefail


HUGO_CONTENT_DIR="content"

HUGO_CONFIG="./config-prod.toml"
HUGO_THEMES_DIR="./themes/"

# HUGO_BASE_URL="https://aspose.test"
HUGO_BASE_URL="https://products.aspose.cloud"
FILE_TO_CHECK="./public/barcode/index.html"


usage() {
  cat <<'EOF'
Usage: hugo-server.bash [--dont-serve]

Builds the site, validates the generated output, and optionally launches hugo server.

  --dont-serve    Skip starting hugo server after the build finishes.
EOF
}

DONT_SERVE="false"

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --dont-serve)
      DONT_SERVE="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done


# Go to project root directory
pushd "$(dirname "$0")/.."

# See https://github.com/aspose-cloud/products.aspose.cloud-workflows/blob/main/.github/workflows/barcode-production.yml
./scripts/change-barcode-urls.bash

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

if [[ "${DONT_SERVE}" == "true" ]]; then
  echo "Skipping Hugo server startup (--dont-serve)."
else
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
fi

popd
