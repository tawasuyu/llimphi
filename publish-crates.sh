#!/usr/bin/env bash
# Publica llimphi a crates.io en orden de dependencias (deps primero).
#
# ANTES de correr (una sola vez):
#   1) Andá a https://crates.io/settings/tokens y creá un token (login con GitHub).
#   2) cargo login <tu-token>
#
# Después: ./publish-crates.sh
# Es reanudable: si se corta (rate-limit, red), volvé a correrlo — los ya
# publicados se saltan solos.
set -u
cd "$(dirname "$0")"
while read -r c; do
  [ -z "$c" ] && continue
  echo ">>> publicando $c"
  if out=$(cargo publish -p "$c" 2>&1); then
    echo "    ok"
  else
    if echo "$out" | grep -qiE "already (been )?uploaded|already exists|crate version .* is already"; then
      echo "    (ya estaba publicado, sigo)"
    else
      echo "$out" | tail -8
      echo "!!! se detuvo en: $c  — revisá el error de arriba, arreglá y re-corré el script"
      exit 1
    fi
  fi
  sleep 3
done < PUBLISH-ORDER.txt
echo "=== TODO PUBLICADO ==="
