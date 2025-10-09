#!/usr/bin/env bash

# UPDATE QBITTORRENT PORT
# - Fetches Proton VPN forwarding port
# - Fetches SID token from qBittorrent API
# - Sets qBittorrent forwarding port using API


CURRENT_DIR=$(cd $(dirname $0) && pwd)
source "${CURRENT_DIR}"/../env/qbit.env 

USER="${QBIT_USER}"
PASS="${QBIT_PASS}"


# Grab port
STORED_PORT_FILE="/tmp/gluetun/forwarded_port"
PORT_FILE="/tmp/port.tmp"
docker cp gluetun:"${STORED_PORT_FILE}" "${PORT_FILE}"
PORT=$(cat "${PORT_FILE}")
rm -f "${PORT_FILE}"
if [[ -z $PORT ]] ; then
	echo "No forwarded port found. Exiting."
	exit 1
fi


# Grab session ID (SID) from API
SID=$(curl -i -s -X POST \
	-d "username=${USER}&password=${PASS}" \
	http://localhost:8080/api/v2/auth/login \
	| egrep -o 'SID=.{32}' | cut -c 5-)


# Update port using API
curl -X POST -s \
	-d "json={\"listen_port\": ${PORT}}" \
	--cookie "SID=${SID}" \
	http://localhost:8080/api/v2/app/setPreferences


echo "$(date) - qBittorrent forwarding port updated to: ${PORT}"

