#!/usr/bin/env bash
set -ex

# Remove Mail Reader shortcut from XFCE menu
if [ -f /usr/share/applications/exo-mail-reader.desktop ]; then
    rm -f /usr/share/applications/exo-mail-reader.desktop
fi

# Remove Printers shortcut from XFCE menu
if [ -f /usr/share/applications/system-config-printer.desktop ]; then
    rm -f /usr/share/applications/system-config-printer.desktop
fi
