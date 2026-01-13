#!/bin/bash
# Flutter Web Build with WebAssembly (WASM) for best rendering performance
# Use this if you need pixel-perfect rendering or heavy graphics
# Note: Larger initial download but better rendering performance

set -e

echo "🚀 Starting WASM Flutter Web build..."

flutter clean
flutter pub get

echo "🔨 Building with WebAssembly..."
flutter build web \
  --release \
  --wasm \
  -O4 \
  --tree-shake-icons \
  --pwa-strategy=offline-first \
  --no-source-maps

echo "✅ Build complete!"
du -sh build/web/
