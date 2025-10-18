# macOS Menu Bar CPU Temperature App

This small Python app adds a status-item to the macOS menu bar showing your CPU temperature.

Requirements
- Homebrew (https://brew.sh) for installing `osx-cpu-temp` (recommended)
- Python 3.8+ and `pip`
- `rumps` Python package

Install

1. Install the CLI temperature tool (recommended):

```bash
brew install osx-cpu-temp
```

2. Install Python dependencies:

```bash
pip install -r requirements.txt
```

Run

From the `9.25` directory run:

```bash
python3 menu_temp.py
```

Usage

- The app shows a short temperature label in the menu bar.
- Click the menu to Refresh, view Details, or Quit.

Notes and packaging
- If you want a standalone macOS app bundle, consider `py2app` or `pyinstaller`.
- `osx-cpu-temp` is the simplest data source. If it's not installed, the script will try `powermetrics` (which may require `sudo`).

Packaging with py2app

1. Create an icon file named `app_icon.icns` in the same folder as `menu_temp.py` (optional).
2. Install build dependency:

```bash
pip install py2app
```

3. Build the app:

```bash
python3 setup.py py2app
```

The built .app will appear in `dist/MenuTemp.app`.

If you prefer `pyinstaller` you can also create an .app or onefile binary; let me know and I can add a `pyinstaller` spec.

Security
- `powermetrics` may require elevated privileges; use with caution.
