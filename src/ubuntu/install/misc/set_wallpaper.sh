#!/usr/bin/env bash
set -ex

# Define wallpaper source and destination
WALLPAPER_SOURCE_PATH="$INST_DIR/ubuntu/install/misc/backgrounds/mtc-wallpaper.png"
DEFAULT_WALLPAPER_PATH="/usr/share/backgrounds/bg_default.png"

# Create destination directory if it doesn't exist
mkdir -p /usr/share/backgrounds/

# Replace the default XFCE wallpaper
cp "${WALLPAPER_SOURCE_PATH}" "${DEFAULT_WALLPAPER_PATH}"
