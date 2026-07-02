#!/usr/bin/env bash
# Package a built TrussC.docset into TrussC.tgz for Zeal/Dash distribution.
#
#   ./package.sh [<path-to-TrussC.docset>] [<output.tgz>]
#
# Defaults: ./TrussC.docset  ->  ./TrussC.tgz
# Build the .docset first in the TrussC repo (see README §"Build & package").
set -euo pipefail

SRC="${1:-TrussC.docset}"
OUT="${2:-TrussC.tgz}"

if [ ! -d "$SRC" ]; then
    echo "error: '$SRC' not found." >&2
    echo "Build it in the TrussC repo, then copy it here (or pass its path):" >&2
    echo "  cd /path/to/TrussC/docs/reference && node emit-dash.js" >&2
    echo "  cp -r build/TrussC.docset ." >&2
    exit 1
fi

# tar with the .docset at the archive root (Dash/Zeal expects this); drop macOS cruft
tar --exclude='.DS_Store' -czf "$OUT" -C "$(dirname "$SRC")" "$(basename "$SRC")"

echo "wrote $OUT ($(du -h "$OUT" | cut -f1))"
