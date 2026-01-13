#!/bin/bash
# Optimized Flutter Web Build Script for Bright Weddings
# This script builds the Flutter web app with maximum performance optimizations

set -e

echo "🚀 Starting optimized Flutter Web build..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build with optimizations
# --release: Production build with optimizations
# -O4: Maximum Dart optimization level
# --tree-shake-icons: Remove unused Material icons
# --pwa-strategy=offline-first: Better caching strategy
# --no-source-maps: Smaller bundle (no debug maps)

echo "🔨 Building optimized web release..."
flutter build web \
  --release \
  -O4 \
  --tree-shake-icons \
  --pwa-strategy=offline-first \
  --no-source-maps

echo "✅ Build complete!"
echo ""
echo "📊 Build output size:"
du -sh build/web/
echo ""
echo "📁 Main bundle size:"
du -sh build/web/main.dart.js 2>/dev/null || echo "main.dart.js not found (may be split)"
echo ""
echo "🌐 To test locally, run:"
echo "   cd build/web && python3 -m http.server 8080"
echo ""
echo "🚀 To deploy to Firebase:"
echo "   firebase deploy --only hosting"
