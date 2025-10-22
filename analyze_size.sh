#!/bin/bash

# App Bundle Size Analysis Script
# Helps analyze and optimize for the 16KB requirement

echo "📊 Android App Bundle Size Analysis"
echo "=================================="

AAB_FILE="build/app/outputs/bundle/release/app-release.aab"

if [ ! -f "$AAB_FILE" ]; then
    echo "❌ AAB file not found. Please build first:"
    echo "   flutter build appbundle --release"
    exit 1
fi

echo "📁 Bundle file: $AAB_FILE"
echo "📏 Bundle size: $(du -h "$AAB_FILE" | cut -f1)"

if command -v bundletool &> /dev/null; then
    echo ""
    echo "🔍 Detailed size analysis:"
    
    # Generate APKs for analysis
    bundletool build-apks --bundle="$AAB_FILE" --output=temp_analysis.apks --mode=universal
    
    # Show size breakdown
    echo ""
    echo "📱 Universal APK size:"
    bundletool get-size total --apks=temp_analysis.apks
    
    # Cleanup
    rm -f temp_analysis.apks
    
    echo ""
    echo "💡 Tips for 16KB optimization:"
    echo "   • Use --split-debug-info to separate debug symbols"
    echo "   • Enable R8 code shrinking and obfuscation"
    echo "   • Use dynamic feature modules for large components"
    echo "   • Optimize images and use WebP format"
    echo "   • Remove unused dependencies"
    
else
    echo ""
    echo "💡 Install bundletool for detailed analysis:"
    echo "   https://github.com/google/bundletool/releases"
fi

# Check asset sizes
echo ""
echo "📂 Asset sizes:"
find assets -type f -exec du -h {} + | sort -hr | head -10

echo ""
echo "✅ Analysis complete!"