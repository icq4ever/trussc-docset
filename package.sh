#!/usr/bin/env bash
# Package a built TrussC.docset into TrussC.zip + TrussC.tgz for Zeal/Dash distribution.
#
#   ./package.sh [<path-to-TrussC.docset>] [<basename>]
#
# Defaults: ./TrussC.docset  ->  ./TrussC.zip and ./TrussC.tgz
# Build the .docset first in the TrussC repo (see README §"Build & package").
set -euo pipefail

SRC="${1:-TrussC.docset}"
BASE="${2:-TrussC}"

if [ ! -d "$SRC" ]; then
    echo "error: '$SRC' not found." >&2
    echo "Build it in the TrussC repo, then copy it here (or pass its path):" >&2
    echo "  cd /path/to/TrussC/docs/reference && node emit-dash.js" >&2
    echo "  cp -r build/TrussC.docset ." >&2
    exit 1
fi

DIR="$(cd "$(dirname "$SRC")" && pwd)"
NAME="$(basename "$SRC")"
ZIP="$DIR/$BASE.zip"
TGZ="$DIR/$BASE.tgz"

# Both archives keep the .docset at the archive root (Dash/Zeal expect this) and
# drop macOS cruft. zip = friendliest on Windows/macOS; tgz = for Linux/tar users.
rm -f "$ZIP" "$TGZ"
( cd "$DIR" && zip -r -q -X "$ZIP" "$NAME" -x '*.DS_Store' )
tar --exclude='.DS_Store' -czf "$TGZ" -C "$DIR" "$NAME"

echo "wrote $ZIP ($(du -h "$ZIP" | cut -f1))"
echo "wrote $TGZ ($(du -h "$TGZ" | cut -f1))"
