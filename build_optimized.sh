#!/bin/bash

# Build script for optimized Android App Bundle with 16KB considerations
# This script helps generate the most optimized AAB for Google Play

echo "🚀 Starting optimized Android App Bundle build..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
cd android && ./gradlew clean && cd ..

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Build optimized AAB
echo "🔧 Building optimized Android App Bundle..."
flutter build appbundle --release \
  --shrink \
  --obfuscate \
  --split-debug-info=debug-symbols/ \
  --tree-shake-icons \
  --dart-define=flutter.inspector.structuredErrors=false

echo "✅ Build complete!"
echo "📁 AAB location: build/app/outputs/bundle/release/app-release.aab"
echo "🐛 Debug symbols: debug-symbols/"

# Optional: Analyze bundle size
echo "📊 Analyzing bundle..."
if command -v bundletool &> /dev/null; then
    bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=app.apks
    bundletool get-size total --apks=app.apks
    echo "📱 Use 'bundletool get-size total --apks=app.apks' to check size breakdown"
else
    echo "💡 Install bundletool to analyze bundle size: https://github.com/google/bundletool"
fi

echo "🎉 Optimized build ready for Google Play!"