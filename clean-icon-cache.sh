#!/bin/sh
# Clear macOS icon caches and restart Dock and Finder.
# Options: --yes       skip the confirmation prompt
#          --dry-run   preview deletions without changing anything
set -eu

DRY_RUN=0
ASSUME_YES=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --yes|-y) ASSUME_YES=1 ;;
    -h|--help)
      echo "Usage: $0 [--yes] [--dry-run]"
      exit 0 ;;
    *)
      echo "Unknown option: $arg" >&2
      exit 1 ;;
  esac
done

if [ "$DRY_RUN" -eq 0 ] && [ "$ASSUME_YES" -eq 0 ]; then
  printf "Clear macOS icon caches and restart Dock/Finder? [y/N] "
  read -r answer
  case "$answer" in
    y|Y|yes|YES) ;;
    *) echo "Aborted."; exit 0 ;;
  esac
fi

sudo -v

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] Would delete:"
  sudo find /private/var/folders \( -name com.apple.dock.iconcache -o -name com.apple.iconservices \) -print
  echo "[dry-run] Would delete /Library/Caches/com.apple.iconservices.store"
else
  # Remove the per-user Dock icon cache and icon services caches.
  sudo find /private/var/folders \( -name com.apple.dock.iconcache -o -name com.apple.iconservices \) -exec rm -rfv -- {} +
  # Remove the shared icon services cache.
  sudo rm -rfv /Library/Caches/com.apple.iconservices.store
fi

if [ "$DRY_RUN" -eq 0 ]; then
  # Restart Dock and Finder so icon caches are rebuilt.
  killall Dock 2>/dev/null || true
  killall Finder 2>/dev/null || true
fi
