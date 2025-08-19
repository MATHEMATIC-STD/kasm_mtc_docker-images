#!/usr/bin/env bash
set -ex

# Copy the welcome message file to the default user profile directory
WELCOME_MSG_SOURCE="$INST_DIR/ubuntu/install/misc/welcome_message.txt"
WELCOME_MSG_DEST="/home/kasm-default-profile/.welcome_message.txt"

cp "${WELCOME_MSG_SOURCE}" "${WELCOME_MSG_DEST}"
chown 1000:0 "${WELCOME_MSG_DEST}"
