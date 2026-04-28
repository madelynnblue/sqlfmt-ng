#!/usr/bin/env bash
set -euo pipefail

SERVE=0
PORT=8012

for arg in "$@"; do
    case "$arg" in
        --serve|-s) SERVE=1 ;;
        --port=*)   PORT="${arg#--port=}" ;;
        *) echo "usage: $0 [--serve|-s] [--port=N]" >&2; exit 1 ;;
    esac
done

wasm-pack build web --target web --out-dir ../docs/wasm --release

if [[ $SERVE -eq 1 ]]; then
    echo "Serving on http://localhost:$PORT"
    python3 -m http.server "$PORT" --directory docs
fi
