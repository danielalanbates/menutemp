# MenuTemp - Publishing Guide

## 📦 Ready for Distribution

MenuTemp v1.0 is ready for publishing!

### App Details

**Name**: MenuTemp
**Version**: 1.0
**Bundle ID**: com.menutemp.app
**Category**: Utilities
**Platform**: macOS 11.0+
**Architecture**: Apple Silicon (arm64)

### Features

✅ Real-time CPU temperature monitoring
✅ Temperature unit toggle (°F/°C) with saved preference
✅ Color-coded temperature display (blue/yellow/orange/red)
✅ Cute thermometer icon in Details dialog
✅ Menu bar only (no Dock icon)
✅ Auto-updates every 30 seconds
✅ Fallback to CPU power when sensors unavailable

### App Structure

```
MenuTemp.app/
├── Contents/
│   ├── Info.plist
│   ├── MacOS/
│   │   └── MenuTemp (162KB Swift executable)
│   └── Resources/
│       ├── app_icon.icns (61KB)
│       ├── get_temp.py (temperature detection)
│       ├── get_temp_advanced.py (advanced detection)
│       └── *.png (UI icons)
```

### Installation Methods

#### Method 1: Simple Copy
```bash
cp -r MenuTemp.app /Applications/
open /Applications/MenuTemp.app
```

#### Method 2: With Auto-Launch
```bash
# Run the install script
./install.sh
```

This will:
- Copy app to /Applications/
- Set up LaunchAgent for auto-start
- Launch the app

### Distribution Checklist

- [x] Swift code compiled without warnings
- [x] All resources bundled in app
- [x] Info.plist configured correctly
- [x] Icon file included
- [x] Python scripts executable
- [x] App tested and running
- [x] Menu items simplified
- [x] Details dialog has cute icon
- [x] Temperature unit toggle working
- [x] README.md updated
- [x] Installation script ready

### Menu Structure

```
🌡️ 72.5°F
────────────────
Temp: 72.5°F
────────────────
Details         ⌘D
────────────────
Celsius         ⌘U
────────────────
Quit            ⌘Q
```

### Next Steps for Publishing

1. **Code Signing** (optional but recommended):
   ```bash
   codesign --force --deep --sign "Developer ID Application" MenuTemp.app
   ```

2. **Notarization** (for distribution outside App Store):
   ```bash
   # Create ZIP for notarization
   ditto -c -k --keepParent MenuTemp.app MenuTemp.zip

   # Submit for notarization
   xcrun notarytool submit MenuTemp.zip --apple-id "your@email.com" --team-id "TEAMID" --password "app-specific-password"
   ```

3. **Create DMG** (for distribution):
   ```bash
   hdiutil create -volname "MenuTemp" -srcfolder MenuTemp.app -ov -format UDZO MenuTemp.dmg
   ```

4. **GitHub Release**:
   - Create release tag v1.0
   - Upload MenuTemp.app.zip
   - Upload MenuTemp.dmg
   - Include README.md as release notes

5. **App Store** (if desired):
   - Add entitlements
   - Configure App Store Connect
   - Submit via Xcode

### Uninstallation

```bash
# Stop the app
killall MenuTemp

# Remove launch agent (if installed)
launchctl unload ~/Library/LaunchAgents/com.daniel.menutemp.plist
rm ~/Library/LaunchAgents/com.daniel.menutemp.plist

# Remove app
rm -rf /Applications/MenuTemp.app
```

### Support

Users can report issues at: [Your GitHub Issues URL]

### License

MIT License - Free to use and distribute

---

**Build Date**: October 18, 2025
**Build System**: macOS Darwin 24.6.0
**Swift Version**: Swift compiler (included in Xcode)
**Python Version**: 3.x (system Python)
