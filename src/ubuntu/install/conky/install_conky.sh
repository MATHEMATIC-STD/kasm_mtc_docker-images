#!/usr/bin/env bash
set -ex

# Install Conky
apt-get update
apt-get install -y conky-all

# Copy the default conkyrc to the default user profile directory
# This will be the placeholder that the user can override with Kasm volume mapping.
CONKY_CONFIG_SOURCE="$INST_DIR/ubuntu/install/conky/conkyrc"
CONKY_CONFIG_DEST="/home/kasm-default-profile/.conkyrc"

cp "${CONKY_CONFIG_SOURCE}" "${CONKY_CONFIG_DEST}"
chown 1000:0 "${CONKY_CONFIG_DEST}"
