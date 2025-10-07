#!/usr/bin/env bash
set -euo pipefail

# Go to project root directory
pushd "$(dirname "$0")/.."

# Flag to track broken symlinks
exit_code=0

# Find and verify
while IFS= read -r -d '' link; do
    target=$(readlink -f "$link" 2>/dev/null || true)
    if [[ ! -e "$target" ]]; then
        echo "❌ BROKEN: $link → $(readlink "$link")"
        exit_code=1
    fi
done < <(find . -type l -print0)

# Summary
if [[ $exit_code -eq 0 ]]; then
    echo "✅ All symlinks are valid."
else
    echo "⚠️ broken symlinks found."
fi

popd

exit $exit_code
