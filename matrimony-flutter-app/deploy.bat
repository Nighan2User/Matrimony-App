@echo off
echo Building Flutter web app...
flutter build web

echo Build completed!
echo.
echo To deploy to Vercel:
echo 1. Make sure you have Vercel CLI installed: npm i -g vercel
echo 2. Run: vercel --prod
echo 3. Or connect your GitHub repo to Vercel dashboard
echo.
echo Build output is in: build/web/
pause
