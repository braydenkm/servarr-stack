# Servarr Aliases

# Useful Aliases for navigating, managing docker stacks, and tools.

# Set these to root Servarr and Media directories.
SERVARR_DIR="${HOME}/servarr"
MEDIA_DIR="/mnt/media/servarr"

# Navigation
alias servarr="cd ${SERVARR_DIR}"
alias downloads="cd ${MEDIA_DIR}/downloads"
alias anime="cd ${MEDIA_DIR}/anime"
alias tv="cd ${MEDIA_DIR}/tv"
alias movies="cd ${MEDIA_DIR}/movies"

# Start/Stop Stacks
alias arr-up="(cd ${SERVARR_DIR}/arr-stack; docker-compose up -d);"
alias arr-down="(cd ${SERVARR_DIR}/arr-stack; docker-compose down);"
alias arr-restart="arr-down arr-up"
alias jelly-up="(cd ${SERVARR_DIR}/jellyfin-stack; docker-compose up -d);"
alias jelly-down="(cd ${SERVARR_DIR}/jellyfin-stack; docker-compose down);"
alias jelly-restart="jelly-down jelly-up"

# Tools
alias vpn-port="${SERVARR_DIR}/tools/update-qbit-port.sh"

