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
sc mining disini (ganti)

# Setelah program utama selesai, hentikan keep-alive
kill $KEEP_PID 2>/dev/null