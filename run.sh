#!/usr/bin/env bash

set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP="$ROOT/app"

echo "==> Installing system dependencies..."
sudo apt-get update
sudo apt-get install -y ffmpeg mediainfo

cd "$APP"

echo "==> Installing application dependencies..."
npm install

echo "==> Fixing Electron sandbox..."
SANDBOX="$APP/node_modules/electron/dist/chrome-sandbox"

if [ -f "$SANDBOX" ]; then
    sudo chown root:root "$SANDBOX"
    sudo chmod 4755 "$SANDBOX"
fi

echo "==> Starting TransientStream..."
npm start
