#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for plist in "$SCRIPT_DIR"/*.plist; do
    if [ -f "$plist" ]; then
        sudo chown root:wheel "$plist"
        sudo ln -sf "$plist" /Library/LaunchDaemons/
        echo "Linked: $plist → /Library/LaunchDaemons/"
    fi
done

sudo launchctl bootstrap system /Library/LaunchDaemons/com.shahmeerathar.karabiner-vhiddaemon.plist
sudo launchctl enable system/com.shahmeerathar.karabiner-vhiddaemon.plist

sudo launchctl bootstrap system /Library/LaunchDaemons/com.shahmeerathar.karabiner-vhidmanager.plist
sudo launchctl enable system/com.shahmeerathar.karabiner-vhidmanager.plist

sudo launchctl bootstrap system /Library/LaunchDaemons/com.shahmeerathar.kanata.plist
sudo launchctl enable system/com.shahmeerathar.kanata.plist

echo "Reboot now"
