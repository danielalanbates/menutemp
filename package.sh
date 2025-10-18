#!/bin/bash

# MenuTemp Packaging Script
# Creates a distributable ZIP of the MenuTemp application

echo "📦 Packaging MenuTemp for Distribution"
echo "======================================"
echo ""

# Check if app exists
if [ ! -d "MenuTemp.app" ]; then
    echo "❌ Error: MenuTemp.app not found"
    echo "Please run this script from the Menu_temp directory"
    exit 1
fi

# Clean up any previous packages
rm -f MenuTemp.zip MenuTemp-v1.0.zip

# Create ZIP archive
echo "🗜️  Creating ZIP archive..."
ditto -c -k --keepParent MenuTemp.app MenuTemp-v1.0.zip

if [ $? -eq 0 ]; then
    SIZE=$(du -h MenuTemp-v1.0.zip | cut -f1)
    echo "✅ Package created: MenuTemp-v1.0.zip ($SIZE)"
    echo ""
    echo "📋 Package contents:"
    echo "   - MenuTemp.app (complete application bundle)"
    echo "   - Swift executable (arm64)"
    echo "   - Python temperature scripts"
    echo "   - App icon and resources"
    echo ""
    echo "🚀 Ready for distribution!"
    echo ""
    echo "Next steps:"
    echo "1. Test the app: open MenuTemp.app"
    echo "2. Create GitHub release with MenuTemp-v1.0.zip"
    echo "3. Optional: Code sign and notarize for wider distribution"
else
    echo "❌ Failed to create package"
    exit 1
fi
