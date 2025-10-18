#!/bin/bash
# Build script for MenuTemp

echo "MenuTemp Build Script"
echo "===================="

# Check if we're in the right directory
if [ ! -f "menu_temp.py" ]; then
    echo "Error: menu_temp.py not found. Please run this script from the Menu_temp directory."
    exit 1
fi

echo "1. Installing dependencies..."
pip3 install -r requirements.txt

echo "2. Checking osx-cpu-temp availability..."
if command -v osx-cpu-temp &> /dev/null; then
    echo "✓ osx-cpu-temp is available"
    osx-cpu-temp
else
    echo "⚠ osx-cpu-temp not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install osx-cpu-temp
    else
        echo "Error: Homebrew not found. Please install osx-cpu-temp manually:"
        echo "  1. Install Homebrew: https://brew.sh"
        echo "  2. Run: brew install osx-cpu-temp"
        exit 1
    fi
fi

echo "3. Testing the application..."
python3 -c "
from menu_temp import get_cpu_temp
temp = get_cpu_temp()
print(f'Current CPU temperature: {temp}')
if temp == 'N/A':
    print('Warning: Temperature reading failed')
else:
    print('✓ Temperature reading successful')
"

echo ""
echo "Build complete! You can now:"
echo "  - Run the app: python3 menu_temp.py"
echo "  - Build macOS app: python3 setup.py py2app"
echo ""