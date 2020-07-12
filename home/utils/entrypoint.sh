#!/bin/bash
# -----------------------------------------------------------------------------
set -euo pipefail # Stop running the script on first error...
# -----------------------------------------------------------------------------
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Change 'sandbox' uid to host user's uid
. ${THIS_DIR}/set-user.sh
. ${THIS_DIR}/git-config.sh

# Start the terminal as the sandbox user...
exec /sbin/su-exec sandbox tmux -u -2 "$@"
