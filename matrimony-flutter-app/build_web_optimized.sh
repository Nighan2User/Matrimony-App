#!/bin/bash
# Ultra-Optimized Flutter Web Build Script for Bright Weddings
# Maximum performance optimizations for fastest loading

set -e

echo "🚀 Starting ultra-optimized Flutter Web build..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Optimize images before build
echo "🖼️ Optimizing images..."
if command -v imageoptim &> /dev/null; then
    find assets/images -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" | xargs imageoptim
elif command -v optipng &> /dev/null && command -v jpegoptim &> /dev/null; then
    find assets/images -name "*.png" -exec optipng -o7 {} \;
    find assets/images -name "*.jpg" -o -name "*.jpeg" -exec jpegoptim --max=85 --strip-all {} \;
else
    echo "⚠️ Image optimization tools not found. Install imageoptim, optipng, or jpegoptim for better compression."
fi

# Build with maximum optimizations
echo "🔨 Building ultra-optimized web release..."
flutter build web \
  --release \
  -O4 \
  --tree-shake-icons \
  --pwa-strategy=offline-first \
  --no-source-maps \
  --dart-define=flutter.web.canvaskit.url=https://unpkg.com/canvaskit-wasm@0.39.1/bin/

# Post-build optimizations
echo "⚡ Applying post-build optimizations..."

# Compress JavaScript files if gzip is available
if command -v gzip &> /dev/null; then
    find build/web -name "*.js" -exec gzip -9 -k {} \;
    echo "✅ JavaScript files compressed with gzip"
fi

# Create .htaccess for Apache servers (if needed)
cat > build/web/.htaccess << 'EOF'
# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
    AddOutputFilterByType DEFLATE application/wasm
</IfModule>

# Cache static assets
<IfModule mod_expires.c>
    ExpiresActive on
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType application/wasm "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
</IfModule>
EOF

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
