#!/bin/sh
# -----------------------------------------------------------------------------
set -euo pipefail # Stop running the script on first error...
# -----------------------------------------------------------------------------

# Git config (if defined)
if [ ! -z "${GIT_USER:-}" ] && [ ! -z "${GIT_EMAIL:-}" ]; then
    git config --global user.name "${GIT_USER}"
    git config --global user.email "${GIT_EMAIL}"
fi