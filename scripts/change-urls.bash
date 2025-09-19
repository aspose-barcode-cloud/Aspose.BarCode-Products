#!/bin/bash
set -euo pipefail

DST_DIR="$1"

echo "Find and Replace: url: -> url_ignore: in all *_index.md files in ${DST_DIR}"
find -L "${DST_DIR}" -type f -name "_index.md" -exec sed -i 's/^url:/url_ignore:/g' {} +
echo "URLs were replaced"
