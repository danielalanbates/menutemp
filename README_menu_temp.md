# macOS Menu Bar CPU Temperature App# macOS Menu Bar CPU Temperature App



This small app adds a status-item to the macOS menu bar showing your CPU temperature. Available in both Python and Swift implementations.This small Python app adds a status-item to the macOS menu bar showing your CPU temperature.



## FeaturesRequirements

- Homebrew (https://brew.sh) for installing `osx-cpu-temp` (recommended)

- Displays real-time CPU temperature in the menu bar- Python 3.8+ and `pip`

- Auto-refreshes every 30 seconds- `rumps` Python package

- Manual refresh and detailed view options

- Works with `osx-cpu-temp` and `powermetrics`Install

- Can be packaged as a standalone macOS app

1. Install the CLI temperature tool (recommended):

## Requirements

```bash

- macOS 10.14 or laterbrew install osx-cpu-temp

- Homebrew (https://brew.sh) for installing `osx-cpu-temp` (recommended)```

- Python 3.8+ and `pip` (for Python version)

- Xcode (for Swift version)2. Install Python dependencies:



## Quick Start```bash

pip install -r requirements.txt

### Option 1: Automated Setup```



```bashRun

./build.sh

```From the `9.25` directory run:



This script will:```bash

- Install Python dependenciespython3 menu_temp.py

- Install osx-cpu-temp if needed```

- Test the application

- Show next stepsUsage



### Option 2: Manual Setup- The app shows a short temperature label in the menu bar.

- Click the menu to Refresh, view Details, or Quit.

1. Install the CLI temperature tool (recommended):

Notes and packaging

```bash- If you want a standalone macOS app bundle, consider `py2app` or `pyinstaller`.

brew install osx-cpu-temp- `osx-cpu-temp` is the simplest data source. If it's not installed, the script will try `powermetrics` (which may require `sudo`).

```

Packaging with py2app

2. Install Python dependencies:

1. Create an icon file named `app_icon.icns` in the same folder as `menu_temp.py` (optional).

```bash2. Install build dependency:

pip3 install -r requirements.txt

``````bash

pip install py2app

## Running the App```



### Python Version3. Build the app:



```bash```bash

python3 menu_temp.pypython3 setup.py py2app

``````



### Swift VersionThe built .app will appear in `dist/MenuTemp.app`.



```bashIf you prefer `pyinstaller` you can also create an .app or onefile binary; let me know and I can add a `pyinstaller` spec.

swift menu_temp.swift

```Security

- `powermetrics` may require elevated privileges; use with caution.

Or compile and run:

```bash
swiftc -o MenuTemp menu_temp.swift
./MenuTemp
```

## Usage

- The app shows a temperature reading in the menu bar
- Click the menu to:
  - **Refresh**: Update temperature immediately
  - **Details**: View detailed temperature information
  - **Quit**: Exit the application

## Building Standalone Apps

### Python App Bundle (py2app)

1. Install build dependency:

```bash
pip3 install py2app
```

2. Build the app:

```bash
python3 setup.py py2app
```

The built .app will appear in `dist/MenuTemp.app`.

### Swift App Bundle

For the Swift version, you can create an Xcode project or use the command line tools to build a proper macOS app bundle.

## Configuration

### Custom Temperature Command

Set the `CPU_TEMP_CMD` environment variable to use a custom temperature reading command:

```bash
export CPU_TEMP_CMD="/path/to/your/temp/command"
python3 menu_temp.py
```

### Temperature Sources

The app tries multiple temperature sources in order:
1. Custom command (via `CPU_TEMP_CMD` environment variable)
2. `osx-cpu-temp` from Homebrew locations
3. `osx-cpu-temp` from system PATH
4. `powermetrics` (may require elevated privileges)

## Files

- `menu_temp.py` - Python implementation with rumps
- `menu_temp.swift` - Swift implementation with native Cocoa
- `requirements.txt` - Python dependencies
- `setup.py` - py2app configuration for building Python app bundle
- `build.sh` - Automated setup script
- `README_menu_temp.md` - This documentation

## Security Notes

- `powermetrics` may require elevated privileges; use with caution
- The app only reads temperature data and doesn't modify system settings

## Troubleshooting

### Temperature shows "N/A"

1. Install osx-cpu-temp: `brew install osx-cpu-temp`
2. Test manually: `osx-cpu-temp`
3. Check permissions for powermetrics access

### Python app won't start

1. Verify Python version: `python3 --version`
2. Install dependencies: `pip3 install -r requirements.txt`
3. Test imports: `python3 -c "import rumps"`

### Swift app compilation issues

1. Verify Xcode command line tools: `xcode-select --install`
2. Check macOS version compatibility

## Development

Both implementations provide the same core functionality:
- Menu bar integration
- Temperature monitoring
- User interface for controls

The Python version uses the `rumps` library for simplicity, while the Swift version provides native Cocoa integration with more advanced features like keychain integration for storing custom commands.