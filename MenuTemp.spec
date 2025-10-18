# -*- mode: python ; coding: utf-8 -*-

a = Analysis(
    ['menu_temp.py'],
    pathex=[],
    binaries=[],
    datas=[],
    hiddenimports=['rumps', 'subprocess', 'os', 'shutil', 're'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='MenuTemp',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='app_icon.icns',
)

coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='MenuTemp',
)

app = BUNDLE(
    coll,
    name='MenuTemp.app',
    icon='app_icon.icns',
    bundle_identifier='com.daniel.menutemp',
    version='1.0.0',
    info_plist={
        'CFBundleName': 'MenuTemp',
        'CFBundleDisplayName': 'CPU Temperature Monitor',
        'CFBundleIdentifier': 'com.daniel.menutemp',
        'CFBundleVersion': '1.0.0',
        'CFBundleShortVersionString': '1.0.0',
        'LSUIElement': True,  # Hide from dock
        'NSHighResolutionCapable': True,
    },
)
