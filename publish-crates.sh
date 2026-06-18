#!/usr/bin/env bash
# Publica llimphi a crates.io en orden de dependencias, esperando solo en rate-limit.
# REQUIERE: cargo login <token>  (una vez).  Uso: ./publish-crates.sh
# Reanudable: salta los ya publicados; en 429 espera 11 min y reintenta el mismo.
set -u
cd "$(dirname "$0")"
while read -r c; do
  [ -z "$c" ] && continue
  while true; do
    echo ">>> publicando $c"
    if out=$(cargo publish -p "$c" 2>&1); then echo "    ok"; break; fi
    if echo "$out" | grep -qiE "already (been )?uploaded|already exists|is already"; then
      echo "    (ya estaba, sigo)"; break
    fi
    if echo "$out" | grep -qiE "429|Too Many Requests|rate.?limit"; then
      echo "    rate-limit; espero 11 min y reintento $c…"; sleep 660; continue
    fi
    echo "$out" | tail -8; echo "!!! error real en $c — corregir y re-correr"; exit 1
  done
  sleep 3
done < PUBLISH-ORDER.txt
echo "=== TODO PUBLICADO ==="
