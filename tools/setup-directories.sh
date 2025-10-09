#!/usr/bin/env bash

# SETUP DIRECTORIES
# - Creates required directories for ServarrStack


# Verify path parameter
if [[ -z $1 || ! -e $1 ]] ; then
	echo "Path required to setup ServarrStack directory"
	exit 1
fi


# Create directories
TARGET_DIR="$1"
mkdir -p "${TARGET_DIR}/downloads"
mkdir -p "${TARGET_DIR}/movies"
mkdir -p "${TARGET_DIR}/anime"
mkdir -p "${TARGET_DIR}/tv"
mkdir -p "${TARGET_DIR}/jellyfin/config"
mkdir -p "${TARGET_DIR}/jellyseerr/config"
mkdir -p "${TARGET_DIR}/qbittorrent/config"
mkdir -p "${TARGET_DIR}/radarr/config"
mkdir -p "${TARGET_DIR}/sonarr/config"
mkdir -p "${TARGET_DIR}/prowlarr/config"


# Done
echo "ServarrStackk directory created."
if command -v tree &>/dev/null ; then
	tree "${TARGET_DIR}"
else
	find "${TARGET_DIR}"
fi

