# 🌡️ MenuTemp - Mac Temperature Monitor

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%2011.0%2B-lightgrey.svg)](https://www.apple.com/macos/)
[![Architecture](https://img.shields.io/badge/arch-arm64-orange.svg)](https://developer.apple.com/documentation/apple-silicon)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](CHANGELOG.md)

A cute, lightweight menu bar temperature monitor for macOS that displays real-time CPU temperature and power consumption with beautiful color-coded indicators.

## ✨ Features

### Core Functionality
- 🌡️ **Real-time Temperature Monitoring** - Displays actual CPU temperature in your menu bar
- 🔄 **Unit Toggle** - Switch between Fahrenheit and Celsius instantly (preference saved)
- ⚡ **Smart Fallback** - Shows CPU power consumption when temperature sensors aren't available
- ⏱️ **Auto-Updates** - Refreshes every 30 seconds automatically

### Visual Design
- 🎨 **Color-Coded Display** - Temperature changes color based on heat level:
  - 🔵 **Blue**: Cool (< 75°F / < 24°C)
  - 🟡 **Yellow**: Mild (75-84°F / 24-29°C)
  - 🟠 **Orange**: Warm (85-94°F / 29-34°C)
  - 🔴 **Red**: Hot (≥ 95°F / ≥ 35°C)
- 💎 **Native SF Symbols** - Beautiful thermometer icon from macOS system icons
- 🎯 **Cute Details Dialog** - Shows comprehensive info with a friendly thermometer icon

### User Experience
- ⌨️ **Keyboard Shortcuts** - Quick access with ⌘D (Details) and ⌘U (Toggle Units)
- 📱 **Menu Bar Only** - Runs discreetly without cluttering your Dock
- 🚀 **Optional Auto-Launch** - Start automatically when you log in
- 💾 **Preference Saving** - Remembers your temperature unit choice

## 📦 Installation

### Quick Install

1. **Download** the [latest release](../../releases/latest)
2. **Unzip** MenuTemp-v1.0.zip
3. **Drag** MenuTemp.app to your Applications folder
4. **Open** MenuTemp from Applications

### Auto-Launch Setup (Optional)

To start MenuTemp automatically when you log in:

```bash
# Clone or download this repository
cd Menu_temp

# Run the installation script
./install.sh
```

This will:
- Copy MenuTemp.app to /Applications/
- Set up a LaunchAgent for auto-start on login
- Launch the app immediately

### Manual Auto-Launch Setup

Alternatively, you can set up auto-launch manually:

1. Open **System Settings** → **General** → **Login Items**
2. Click the **+** button
3. Select **MenuTemp** from Applications
4. Done!

## 🎯 Usage

### Menu Bar Interface

Once launched, MenuTemp appears in your menu bar with a thermometer icon and current temperature:

```
🌡️ 72.5°F
```

**Click the icon** to access:

- **Temp: XX.X°F** - Current reading (non-interactive)
- **Details** (⌘D) - View comprehensive temperature information
- **Celsius** / **Fahrenheit** (⌘U) - Toggle between units
- **Quit** (⌘Q) - Exit the application

### Keyboard Shortcuts

- **⌘D** - Open Details dialog
- **⌘U** - Toggle temperature units (°F ↔ °C)
- **⌘Q** - Quit MenuTemp

### Color Guide

The temperature reading changes color automatically:

| Color | Temperature (°F) | Temperature (°C) | Status |
|-------|------------------|------------------|--------|
| 🔵 Blue | < 75°F | < 24°C | Cool - All good! |
| 🟡 Yellow | 75-84°F | 24-29°C | Mild - Normal operation |
| 🟠 Orange | 85-94°F | 29-34°C | Warm - Getting toasty |
| 🔴 Red | ≥ 95°F | ≥ 35°C | Hot - Time to cool down! |

## 🔧 Technical Details

### System Requirements

- **OS**: macOS 11.0 (Big Sur) or later
- **Architecture**: Apple Silicon (arm64)
- **Python**: Python 3.x (included with macOS)

### Temperature Detection Methods

MenuTemp tries multiple methods to get accurate temperature readings:

1. **Advanced Python Script** - Uses IOKit and system thermal sensors
2. **Powermetrics** - Apple's system monitoring tool
3. **CPU Power Fallback** - Shows power consumption when sensors unavailable

### Architecture

```
MenuTemp.app/
├── Contents/
│   ├── Info.plist              # App metadata
│   ├── MacOS/
│   │   └── MenuTemp            # Swift executable (162KB)
│   └── Resources/
│       ├── app_icon.icns       # App icon
│       ├── get_temp.py         # Basic temperature detection
│       └── get_temp_advanced.py # Advanced IOKit detection
```

**Tech Stack:**
- **Swift** - Native macOS application framework
- **Cocoa/AppKit** - macOS UI components
- **Python 3** - Temperature sensor access
- **SF Symbols** - macOS system icons

## 🛠️ Building from Source

### Prerequisites

- Xcode Command Line Tools
- Swift compiler (included with Xcode)
- Python 3

### Build Steps

```bash
# Clone the repository
git clone https://github.com/yourusername/menutemp.git
cd menutemp

# Compile the Swift app
swiftc menu_temp.swift -o MenuTemp

# Create the app bundle
mkdir -p MenuTemp.app/Contents/{MacOS,Resources}
cp MenuTemp MenuTemp.app/Contents/MacOS/
cp get_temp*.py MenuTemp.app/Contents/Resources/
cp Info.plist MenuTemp.app/Contents/
cp app_icon.icns MenuTemp.app/Contents/Resources/

# Make Python scripts executable
chmod +x MenuTemp.app/Contents/Resources/get_temp*.py

# Test the app
open MenuTemp.app
```

### Creating a Distribution Package

```bash
./package.sh
```

This creates `MenuTemp-v1.0.zip` ready for distribution.

## 🐛 Troubleshooting

### Temperature Shows "No sensors"
- This is normal on some Macs that restrict sensor access
- The app will fallback to showing CPU power consumption instead

### Temperature Shows Power (W or mW)
- This means temperature sensors aren't accessible
- Power consumption is a useful proxy for thermal activity
- This is expected behavior on Apple Silicon Macs with restricted sensor access

### App Doesn't Start
- Ensure Python 3 is installed: `python3 --version`
- Check that Python scripts are in `MenuTemp.app/Contents/Resources/`
- Try running from Terminal to see error messages

### Menu Bar Icon Not Showing
- Check if menu bar is full (try hiding other apps)
- Look in the menu bar overflow area (»)
- Restart MenuTemp

### Temperature Seems Inaccurate
- Click "Details" to see all available temperature sources
- Different sensors may show slightly different values
- The app shows CPU die temperature when available

## 🗑️ Uninstallation

### Simple Removal

```bash
# Stop the app
killall MenuTemp

# Remove from Applications
rm -rf /Applications/MenuTemp.app
```

### Complete Removal (Including Auto-Launch)

```bash
# Stop the app
killall MenuTemp

# Remove launch agent
launchctl unload ~/Library/LaunchAgents/com.daniel.menutemp.plist
rm ~/Library/LaunchAgents/com.daniel.menutemp.plist

# Remove app
rm -rf /Applications/MenuTemp.app

# Remove preferences (optional)
defaults delete com.menutemp.app
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with ❤️ using Swift and macOS native frameworks
- Inspired by the need for a simple, beautiful temperature monitor
- Uses macOS SF Symbols for native icon integration

## 📊 Similar Projects

If MenuTemp doesn't meet your needs, check out these alternatives:

- [Stats](https://github.com/exelban/stats) - Comprehensive system monitor
- [iGlance](https://github.com/iglance/iGlance) - Customizable system monitor
- [Hot](https://github.com/macmade/Hot) - CPU thermal throttling monitor

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Guidelines

1. Follow Swift best practices
2. Test on both Intel and Apple Silicon Macs (if possible)
3. Update CHANGELOG.md with changes
4. Add comments for complex logic
5. Ensure the app builds and runs before submitting

## 📧 Support

Found a bug or have a feature request? Please [open an issue](../../issues/new).

---

**Made with 🌡️ for macOS**
