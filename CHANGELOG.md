# Changelog

All notable changes to MenuTemp will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-18

### Added
- Initial release of MenuTemp
- Real-time CPU temperature monitoring in menu bar
- Temperature unit toggle (°F/°C) with persistent preference
- Color-coded temperature display:
  - Blue for cool temperatures (<75°F / <24°C)
  - Yellow for mild temperatures (75-84°F / 24-29°C)
  - Orange for warm temperatures (85-94°F / 29-34°C)
  - Red for hot temperatures (≥95°F / ≥35°C)
- Details dialog with cute thermometer icon
- Auto-updates every 30 seconds
- Multiple temperature detection methods:
  - Advanced Python script with IOKit integration
  - Powermetrics CPU temperature
  - CPU power consumption as fallback
- Menu bar only mode (no Dock icon)
- Native macOS SF Symbols icons
- Keyboard shortcuts:
  - ⌘D for Details
  - ⌘U for temperature unit toggle
  - ⌘Q for Quit

### Technical Details
- Built with Swift for native macOS performance
- Python 3 integration for temperature sensor access
- Supports Apple Silicon (arm64) Macs
- Requires macOS 11.0 or later
- Lightweight footprint (~85KB packaged)

### Files Included
- MenuTemp.app - Complete application bundle
- Swift source code (menu_temp.swift)
- Python temperature detection scripts
- Installation script with LaunchAgent setup
- Comprehensive documentation
