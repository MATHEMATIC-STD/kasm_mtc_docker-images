#!/usr/bin/env bash
set -ex

# --- Staging Area for Mapped Files ---
# Copy user-provided config files from a staging area to the home directory,
# overwriting the defaults from the image. This runs after Kasm's profile init.
STAGING_DIR="/kasm_staging"
if [ -d "$STAGING_DIR" ]; then
    # Copy Conky config if it exists
    if [ -f "$STAGING_DIR/.conkyrc" ]; then
        cp "$STAGING_DIR/.conkyrc" "$HOME/.conkyrc"
        echo "Custom .conkyrc applied."
    fi

    # Copy Welcome Message if it exists
    if [ -f "$STAGING_DIR/.welcome_message.txt" ]; then
        cp "$STAGING_DIR/.welcome_message.txt" "$HOME/.welcome_message.txt"
        echo "Custom .welcome_message.txt applied."
    fi
fi


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