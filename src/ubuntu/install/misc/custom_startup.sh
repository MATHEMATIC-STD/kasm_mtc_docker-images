#!/usr/bin/env bash
set -ex

# --- SMB/CIFS Mount Configuration ---
# Default to environment variables, but allow overrides for testing
SMB_MOUNT_POINT="/home/kasm-user/SAS"

mkdir -p "${SMB_MOUNT_POINT}"

# Prepare mount options
MOUNT_OPTIONS="rw,user,exec,async,_netdev,nofail,uid=1000,gid=1000"

if [ -n "${SMB_USER}" ] && [ -n "${SMB_PASSWORD}" ]; then
    echo "Attempting to mount with credentials..."
    MOUNT_OPTIONS="${MOUNT_OPTIONS},username=${SMB_USER},password=${SMB_PASSWORD}"
    echo "${SMB_PASSWORD}" > /home/kasm-user/.smb_creds
    chmod 600 /home/kasm-user/.smb_creds
    MOUNT_OPTIONS="${MOUNT_OPTIONS},credentials=/home/kasm-user/.smb_creds"
elif [ -n "${SMB_USER}" ]; then
    echo "Attempting to mount with username only..."
    MOUNT_OPTIONS="${MOUNT_OPTIONS},username=${SMB_USER}"
else
    echo "Attempting to mount as guest..."
    MOUNT_OPTIONS="${MOUNT_OPTIONS},guest"
fi

# Mount the share
if [ -n "${SMB_SERVER}" ] && [ -n "${SMB_SHARE}" ]; then
    mount -t cifs "//${SMB_SERVER}/${SMB_SHARE}" "${SMB_MOUNT_POINT}" -o "${MOUNT_OPTIONS}"
    
    # Verify mount success
    if ! mountpoint -q "${SMB_MOUNT_POINT}"; then
        zenity --error --text="Impossible de monter le partage r\u00e9seau SMB/CIFS. V\u00e9rifiez la configuration."
        exit 1
    fi
else
    zenity --info --text="Les variables pour le montage SMB (SMB_SERVER, SMB_SHARE) ne sont pas d\u00e9finies. Le r\u00e9pertoire SAS est local."
fi

# --- Start Application ---
/usr/bin/filter_ready
/usr/bin/desktop_ready

# Start Brave Browser (no loop)
brave-browser --no-sandbox --start-maximized

# Keep container alive if Brave is closed
while true; do sleep 1; done
