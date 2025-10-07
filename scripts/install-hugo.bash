#!/usr/bin/env bash
set -euo pipefail

# Go to project root directory
pushd "$(dirname "$0")/.."

# Extended build (for SCSS/SASS)
EXTENDED=1

VER="$(tr -d '[:space:]' < .hugo_version)"

# Set EXTENDED=1 to build extended
EXTENDED="${EXTENDED:-1}"
ARGS=()
if [[ "$EXTENDED" == "1" ]]; then
  export CGO_ENABLED=1
  ARGS+=(-tags extended)
fi

echo "Installing Hugo ${VER} (extended=${EXTENDED})..."
go install "${ARGS[@]}" "github.com/gohugoio/hugo@v${VER}"

BIN="$(go env GOPATH)/bin/hugo"
echo "Installed: $($BIN version)"

hugo version || echo "Make sure $(go env GOPATH)/bin is on your PATH."
