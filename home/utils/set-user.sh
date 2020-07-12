#!/bin/sh
# -----------------------------------------------------------------------------
set -euo pipefail # Stop running the script on first error...
# -----------------------------------------------------------------------------

# Get standard cali USER_ID variable
USER_ID=${USER_ID:-9001}
GROUP_ID=${GROUP_ID:-9001}

# Change 'sandbox' uid to host user's uid
if [ ! -z "$USER_ID" ] && [ "$(id -u sandbox)" != "$USER_ID" ]; then
    echo "Linking user [ $USER_ID ] (group ${GROUP_ID})"
    
    # Create the user group if it does not exist
    groupadd --non-unique -g "$GROUP_ID" devs
    
    # Set the user's uid and gid
    usermod --non-unique --uid "$USER_ID" --gid "$GROUP_ID" sandbox
    
    # Own the home dir and docker socket (if bound)
    chown -R sandbox: /home/sandbox
    chown -R sandbox: /workspace
    if [ -d /var/run/docker.sock ]; then
        chown sandbox: /var/run/docker.sock || true
    fi
fi