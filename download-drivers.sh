#!/usr/bin/env bash
set -euo pipefail

PLUGINS_DIR="${MB_PLUGINS_DIR:-/plugins}"
mkdir -p "$PLUGINS_DIR"

while IFS='=' read -r name value; do
  [[ "$name" == DRIVER_* ]] || continue
  [[ -z "$value" ]] && continue
  filename="$(basename "$value")"
  target="$PLUGINS_DIR/$filename"
  if [[ -f "$target" ]]; then
    echo "[drivers] $name -> $filename (cached)"
    continue
  fi
  echo "[drivers] $name -> downloading $value"
  curl -fsSL --retry 3 -o "$target" "$value"
done < <(env)

exec "$@"
