#!/bin/bash
# -----------------------------------------------------------------------------
set -euo pipefail # Stop running the script on first error...
# -----------------------------------------------------------------------------
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

display_help() {
    echo "Usage: $0 [options] <action>" >&2
    echo ""
    echo "Where:"
    echo "   -h, --help             Displays this help message"
    echo "       --debug            Adds the debug flag for additional info used to debug the script"
    echo ""
    echo "Actions:"
    echo "   code                   Opens Visual Studio Code."
    echo ""
}

run() {
    parser "$@" # Parse command line options
    config # configure dev environment

    # Check if a target action was specified
    if [ ! -z "${1:-}" ]; then
        action=$1; shift # past argument        
        case $action in
            code)            
                echo "[${action}] VS Code..."
            ;;
            chrome)
                echo "[${action}] Open Chrome..."
            ;;
            *) # unknown option
                echo "Warning: Action '${action}' not found."
                exit 1
            ;;
        esac
    else
        # Start the terminal as the sandbox user...
        echo "Starting shell..."
        exec /sbin/su-exec sandbox tmux -u -2 "$@"
    fi
}

config() {
    # Change 'sandbox' uid to host user's uid and configure system
    . ${THIS_DIR}/set-user.sh
    . ${THIS_DIR}/git-config.sh
}

parser() {
    POSITIONAL=()

    while [[ $# -gt 0 ]]
    do
        case $1 in
            -h|--help)
                display_help
                exit 0
            ;;
            --debug)
                verbose=Y
                shift # past argument
            ;;
            *) # unknown option
                POSITIONAL+=("$1") # save it in an array for later
                shift # past argument
            ;;
        esac
    done
    # restore positional parameters that could not be matched and parsed
    set -- "${POSITIONAL[@]:-}" 
}

run "$@"