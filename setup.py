"""
Setup script for building macOS app bundle using py2app.

Usage:
    python3 setup.py py2app

The built .app will appear in dist/MenuTemp.app
"""

from setuptools import setup

APP = ['menu_temp.py']
DATA_FILES = []
OPTIONS = {
    'argv_emulation': False,
    'iconfile': 'app_icon.icns',  # Optional: create this file for a custom icon
    'plist': {
        'CFBundleName': 'MenuTemp',
        'CFBundleDisplayName': 'CPU Temperature Monitor',
        'CFBundleIdentifier': 'com.daniel.menutemp',
        'CFBundleVersion': '1.0.0',
        'CFBundleShortVersionString': '1.0.0',
        'LSUIElement': True,  # Hide from dock
        'NSHighResolutionCapable': True,
    },
    'packages': ['rumps'],
    'includes': ['subprocess', 'os', 'shutil', 're'],
}

setup(
    app=APP,
    name='MenuTemp',
    data_files=DATA_FILES,
    options={'py2app': OPTIONS},
    setup_requires=['py2app'],
    install_requires=['rumps'],
)