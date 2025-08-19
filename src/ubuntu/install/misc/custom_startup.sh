#!/usr/bin/env bash
set -ex

# --- Display Welcome Message ---
WELCOME_TEXT="Cet environnement est isolé et sécurisé.\nIl vous permet de naviguer sur internet et d'accéder au stockage SAS."
if [ -n "$KASM_USER" ]; then
    zenity --info --text="Bienvenue, $KASM_USER !\n\n${WELCOME_TEXT}" --timeout=12
else
    zenity --info --text="Bienvenue !\n\n${WELCOME_TEXT}" --timeout=12
fi

# --- Start Application ---
/usr/bin/filter_ready
/usr/bin/desktop_ready

# Start Brave Browser (no loop)
#brave-browser --no-sandbox --start-maximized

# Keep container alive if Brave is closed
while true; do sleep 1; done