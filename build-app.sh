#!/bin/sh
# Build the double-clickable .app from the JXA source.
set -eu

cd "$(dirname "$0")"

out="dist/clean-macOS-icon-cache.app"

if [ -d "$out" ]; then
  rm -rf -- "$out"
fi

mkdir -p dist
osacompile -l JavaScript -o "$out" clean-icon-cache.js

echo "Built: $out"
