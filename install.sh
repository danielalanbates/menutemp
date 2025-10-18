#!/bin/bash

# MenuTemp Installation Script

echo "🌡️ Installing MenuTemp - Mac Temperature Monitor"
echo ""

# Check if we're in the right directory
if [ ! -d "MenuTemp.app" ]; then
    echo "❌ Error: MenuTemp.app not found in current directory"
    echo "Please run this script from the MenuTemp project directory"
    exit 1
fi

# Copy app to Applications
echo "📦 Copying app to Applications folder..."
cp -r MenuTemp.app /Applications/

if [ $? -eq 0 ]; then
    echo "✅ App copied successfully"
else
    echo "❌ Failed to copy app"
    exit 1
fi

# Set up launch agent
echo "🚀 Setting up auto-launch..."
LAUNCH_AGENT_DIR="$HOME/Library/LaunchAgents"
LAUNCH_AGENT_FILE="$LAUNCH_AGENT_DIR/com.daniel.menutemp.plist"

# Create LaunchAgents directory if it doesn't exist
mkdir -p "$LAUNCH_AGENT_DIR"

# Create launch agent plist
cat > "$LAUNCH_AGENT_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.daniel.menutemp</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/open</string>
        <string>-a</string>
        <string>/Applications/MenuTemp.app</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
    <key>LaunchOnlyOnce</key>
    <true/>
</dict>
</plist>
EOF

if [ $? -eq 0 ]; then
    echo "✅ Launch agent created"
else
    echo "❌ Failed to create launch agent"
    exit 1
fi

# Load the launch agent
launchctl load "$LAUNCH_AGENT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Launch agent loaded"
else
    echo "❌ Failed to load launch agent"
fi

# Launch the app
echo "🎯 Launching MenuTemp..."
open /Applications/MenuTemp.app

if [ $? -eq 0 ]; then
    echo "✅ MenuTemp launched!"
else
    echo "❌ Failed to launch MenuTemp"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "MenuTemp will now:"
echo "• Auto-launch when you log in"
echo "• Show temperature in your menu bar"
echo "• Update every 30 seconds"
echo ""
echo "Look for the 🌡️ thermometer icon in your menu bar!"
echo ""
echo "To uninstall:"
echo "launchctl unload ~/Library/LaunchAgents/com.daniel.menutemp.plist"
echo "rm -rf /Applications/MenuTemp.app"