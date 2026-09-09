#!/bin/sh
# Remove the per-user Dock icon cache and icon services caches.
sudo find /private/var/folders/ \( -name com.apple.dock.iconcache -or -name com.apple.iconservices \) -exec rm -rfv {} \;
# Remove the shared icon services cache.
sudo rm -rf /Library/Caches/com.apple.iconservices.store;
# Restart Dock and Finder so icon caches are rebuilt.
killall Dock
killall Finder
