#!/usr/bin/env bash
set -ex

# --- Display Welcome Message ---
WELCOME_MSG_FILE="$HOME/.welcome_message.txt"
if [ -f "$WELCOME_MSG_FILE" ]; then
    WELCOME_TEXT=$(cat "$WELCOME_MSG_FILE")
    if [ -n "$KASM_USER" ]; then
        zenity --info --text="Bienvenue, $KASM_USER !\n\n${WELCOME_TEXT}" --timeout=12
    else
        zenity --info --text="Bienvenue !\n\n${WELCOME_TEXT}" --timeout=12
    fi
fi

# --- Configure and Start Conky ---
CONKY_CONFIG="$HOME/.conkyrc"
if [ -f "$CONKY_CONFIG" ]; then
    # Replace placeholder with actual username, or "Utilisateur" if not set
    USER_NAME=${KASM_USER:-"Utilisateur"}
    sed -i "s/PLACEHOLDER_USER/${USER_NAME}/g" "$CONKY_CONFIG"
    
    # Launch Conky in the background
    conky -c "$CONKY_CONFIG" &
fi

# --- Start Application ---
/usr/bin/filter_ready
/usr/bin/desktop_ready

# Start Brave Browser (no loop)
#brave-browser --no-sandbox --start-maximized

# Keep container alive if Brave is closed
while true; do sleep 1; done