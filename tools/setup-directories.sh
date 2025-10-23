#!/usr/bin/env bash

# SETUP DIRECTORIES
# - Creates required directories for ServarrStack



CONFIG_DIR="/root/servarr/config"
MEDIA_DIR="/mnt/media/servarr"


# Create directories
mkdir -p "${MEDIA_DIR}/downloads"
mkdir -p "${MEDIA_DIR}/movies"
mkdir -p "${MEDIA_DIR}/anime"
mkdir -p "${MEDIA_DIR}/tv"
mkdir -p "${CONFIG_DIR}/jellyfin/config"
mkdir -p "${CONFIG_DIR}/jellyseerr/config"
mkdir -p "${CONFIG_DIR}/qbittorrent/config"
mkdir -p "${CONFIG_DIR}/radarr/config"
mkdir -p "${CONFIG_DIR}/sonarr/config"
mkdir -p "${CONFIG_DIR}/prowlarr/config"


# Done
echo "ServarrStackk directory created."
if command -v tree &>/dev/null ; then
	echo "${MEDIA_DIR}"
	tree -L 1 "${MEDIA_DIR}"
	echo ""
	echo "${CONFIG_DIR}"
	tree -L  2 "${CONFIG_DIR}"
else
	find "${MEDIA_DIR}"
	find "${CONFIG_DIR}"
fi

