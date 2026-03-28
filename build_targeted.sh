#!/bin/bash
# TARGETED WIZARD BYPASS - Mac Compilation
# Uses WizardBypass_Fixed.x (v68) with actual class hooking

set -e

echo "=============================================="
echo "🎯 TARGETED WIZARD BYPASS v68 - MAC BUILD"
echo "=============================================="
echo ""

# Check macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ ERROR: Must run on macOS"
    exit 1
fi

# Check Xcode
if ! xcrun --sdk iphoneos --show-sdk-path &> /dev/null; then
    echo "❌ Install Xcode Command Line Tools: xcode-select --install"
    exit 1
fi

SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
echo "📱 iOS SDK: $SDK_PATH"
echo ""

# Use the TARGETED version (WizardBypass_Fixed.x)
SOURCE_FILE="WizardBypass_Fixed.x"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Source file not found: $SOURCE_FILE"
    echo "Make sure you're in the WizardBypass directory"
    exit 1
fi

echo "🔨 Compiling $SOURCE_FILE..."
echo ""

# Compile with all needed frameworks for targeted approach
clang -arch arm64 \
    -isysroot "$SDK_PATH" \
    -miphoneos-version-min=13.0 \
    -dynamiclib \
    -o WizardBypass.dylib \
    "$SOURCE_FILE" \
    -framework Foundation \
    -framework UIKit \
    -framework QuartzCore \
    -fobjc-arc \
    -Wno-deprecated-declarations

echo ""
echo "✅ Compiled: WizardBypass.dylib"
echo ""

# Verify
echo "📊 File info:"
ls -lh WizardBypass.dylib
file WizardBypass.dylib

echo ""
echo "📋 Dependencies:"
otool -L WizardBypass.dylib

echo ""
echo "🔐 Signing..."
codesign -f -s - WizardBypass.dylib

echo ""
echo "=============================================="
echo "🎉 TARGETED BUILD COMPLETE!"
echo "=============================================="
echo ""
echo "Key features in this build:"
echo "• ABVJSMGADJS class hooking (captures singleton)"
echo "• IKAFHFDSAJ method calling (creates real menu)"
echo "• Keyword-based popup blocking"
echo "• Real Wizard framework integration"
echo ""
echo "Next: Inject into 8 Ball Pool and test!"
