#!/usr/bin/env bash
# Publica llimphi a crates.io en orden de dependencias.
# Reintenta en rate-limit (429, espera 11min) y en errores de red transitorios (30s).
# Reanudable: salta los ya publicados.  Uso: cargo login <token> && ./publish-crates.sh
set -u
cd "$(dirname "$0")"
while read -r c; do
  [ -z "$c" ] && continue
  while true; do
    echo ">>> publicando $c"
    if out=$(cargo publish -p "$c" --no-verify 2>&1); then echo "    ok"; break; fi
    if echo "$out" | grep -qiE "already (been )?uploaded|already exists|is already"; then
      echo "    (ya estaba, sigo)"; break
    elif echo "$out" | grep -qiE "429|Too Many Requests|rate.?limit"; then
      echo "    rate-limit; espero 11 min…"; sleep 660; continue
    elif echo "$out" | grep -qiE "curl failed|HTTP2|http2|download of .* failed|failed to get|connection|timed out|temporary failure|spurious|error sending request|reset by peer|EOF while"; then
      echo "    error de red transitorio; espero 30s y reintento…"; sleep 30; continue
    else
      echo "$out" | tail -8; echo "!!! error real en $c — corregir y re-correr"; exit 1
    fi
  done
  sleep 3
done < PUBLISH-ORDER.txt
echo "=== TODO PUBLICADO ==="
