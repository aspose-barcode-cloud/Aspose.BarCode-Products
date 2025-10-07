#!/bin/bash
set -euo pipefail

# Go to project root directory
pushd "$(dirname "$0")/.."

BARCODE_DIR="./barcode/"

echo "Find and Replace: url: -> url_ignore: in all *_index.md files in ${BARCODE_DIR}"
find "${BARCODE_DIR}" -type f -name "_index.md" -exec sed -i 's/^url:/url_ignore:/g' {} +
echo "URLs were replaced"
