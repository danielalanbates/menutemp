#!/usr/bin/env python3
import subprocess
import os

def create_app_icon():
    """Create a cute thermometer app icon using SF Symbols"""
    
    # Create an AppleScript that generates an icon
    applescript = '''
    tell application "System Events"
        set iconPath to POSIX path of (path to desktop) & "temp_icon.png"
        
        -- Create a simple icon using built-in tools
        do shell script "sips -s format png /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarUtilities.icns --out " & quoted form of iconPath
        
        return iconPath
    end tell
    '''
    
    try:
        # Run the AppleScript
        result = subprocess.run(['osascript', '-e', applescript], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print("Icon created successfully")
        else:
            print("Failed to create icon with AppleScript")
    except Exception as e:
        print(f"Error: {e}")

def create_simple_icon():
    """Create a simple icon using iconutil and existing system resources"""
    
    # Create iconset directory
    iconset_dir = "/Users/daniel/Documents/GitHub/copilot/Menu_temp/AppIcon.iconset"
    os.makedirs(iconset_dir, exist_ok=True)
    
    # Use the system thermometer icon as base
    source_icon = "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarUtilities.icns"
    
    # Create different sizes for the iconset
    sizes = [
        ("16x16", "icon_16x16.png"),
        ("16x16@2x", "icon_16x16@2x.png"),
        ("32x32", "icon_32x32.png"),
        ("32x32@2x", "icon_32x32@2x.png"),
        ("128x128", "icon_128x128.png"),
        ("128x128@2x", "icon_128x128@2x.png"),
        ("256x256", "icon_256x256.png"),
        ("256x256@2x", "icon_256x256@2x.png"),
        ("512x512", "icon_512x512.png"),
        ("512x512@2x", "icon_512x512@2x.png")
    ]
    
    for size_name, filename in sizes:
        size = size_name.replace("@2x", "")
        output_path = os.path.join(iconset_dir, filename)
        
        # Convert system icon to PNG at specific size
        cmd = [
            "sips", "-s", "format", "png",
            "-Z", size.split("x")[0],
            source_icon,
            "--out", output_path
        ]
        
        try:
            subprocess.run(cmd, check=True, capture_output=True)
            print(f"Created {filename}")
        except subprocess.CalledProcessError:
            print(f"Failed to create {filename}")
    
    # Convert iconset to icns
    try:
        subprocess.run([
            "iconutil", "-c", "icns",
            iconset_dir,
            "-o", "/Users/daniel/Documents/GitHub/copilot/Menu_temp/MenuTemp.app/Contents/Resources/AppIcon.icns"
        ], check=True)
        print("Created AppIcon.icns")
        
        # Clean up iconset directory
        subprocess.run(["rm", "-rf", iconset_dir])
        
    except subprocess.CalledProcessError as e:
        print(f"Failed to create icns: {e}")

if __name__ == "__main__":
    create_simple_icon()