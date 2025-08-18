#!/usr/bin/env bash
set -ex

# Configure Thunar to hide the side panel and default to the SAS directory
mkdir -p /home/kasm-default-profile/.config/Thunar
cat > /home/kasm-default-profile/.config/Thunar/thunarrc << EOL
[Configuration]
misc-side-pane-tree-view=FALSE
last-view=ThunarIconView
last-location-bar-path=/home/kasm-user/SAS
last-icon-view-zoom-level=THUNAR_ZOOM_LEVEL_100_PERCENT
last-separator-position=170
EOL

# Set the default desktop icon to open Thunar in the SAS directory
if [ -f /usr/share/applications/thunar.desktop ]; then
    sed -i 's/^Exec=thunar %F/Exec=thunar %f \/home\/kasm-user\/SAS/' /usr/share/applications/thunar.desktop
fi
