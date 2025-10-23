# Servarr Stack
Deployment of Arr stack, qBittorrent, and Jellyfin through Docker.
This repository contains the configuration files for setting up a media server using Docker Compose. The services included are:
- Jellyfin
- Jellyseerr
- Gluetun (Proton VPN)
- qBittorrent
- Radarr
- Sonarr
- Prowlarr


## Github
[github.com/braydenkm/ServarrStack](https://github.com/braydenkm/ServarrStack)


## Ports
The following ports are exposed for the web UIs of the services:
- `8096` - Jellyfin
- `5055` - Jellyseerr
- `8080` - qBittorrent
- `7878` - Radarr
- `8989` - Sonarr
- `9696` - Prowlarr


## Volumes
The following volumes are used to persist data:
- `~/servarr/downloads:/downloads`
- `~/servarr/movies:/movies`
- `~/servarr/anime:/anime`
- `~/servarr/tv:/tv`
- `~/servarr/jellyfin/config:/config`
- `~/servarr/jellyseerr:/config`
- `~/servarr/qbittorrent/config:/config`
- `~/servarr/radarr/config:/config`
- `~/servarr/sonarr/config:/config`
- `~/servarr/prowlarr/config:/config`


## Prerequisites
- Linux
- Docker
- Docker Compose


## Setup
1. Clone the repository.
    ```sh
    git clone git@github.com:braydenkm/ServarrStack
    ```
2. Run the directory mapper script to create the necessary directories and set permissions.
    ```sh
    ./tools/setup-directories.sh /path/to/media/storage
    ```
3. Create the `./env` directory and the following environment variable files and keys:
- `proton.env` - Proton VPN credentials.
  ```sh
  # --- PROTON ENVIRONMENT ---
  # Proton VPN WireGuard
  # Set these values found in Proton VPN Wireguard config
  WIREGUARD_PRIVATE_KEY=VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
  WIREGUARD_ADDRESSES=YY.YY.YY.YY/32
  WIREGUARD_PUBLIC_KEY=ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
  WIREGUARD_ENDPOINT=XX.XX.XX.XX:51820
  
  # - Proton VPN -
  VPN_SERVICE_PROVIDER=protonvpn
  VPN_TYPE=wireguard
  
  # Allow LAN access to qBittorrent, Sonarr, Radarr, etc.
  FIREWALL_OUTBOUND_SUBNETS=192.168.2.0/24
  ```
- `qbit.env` - qBittorrent credentials.
  ```sh
  QBIT_USER=admin
  QBIT_PASS=admin
  ```
- `wg-private.key` - Wireguard private key
- `wg-public.key` - Wireguard public key
4. Add aliases to .bashrc:
    1. Add line to ~/.bashrc `[[ -f ${HOME}/servarr/tools/servarr-aliases.sh ]] && { source "${HOME}/servarr/tools/servarr-aliases.sh"; }`
    2. Save changes and source `. ~/.bashrc`
    3. Verify aliases are set `alias`
5. Start services using the aliases:
    ```sh
    arr-up
    jelly-up
    ```
6. Update qBittorrent's listening port:
    1. Use alias `vpn-port`
8. Setup Cronjob to update qBittorrent's listening port on recurring task:
    1. Edit Crontab `crontab -e`
    2. Add line `*/5 * * * * /root/servarr/tools/update-qbit-port.sh >> /var/log/update-qbit-port.log 2>&1`
    3. This will run the update-qbit-port.sh script every 5 minutes and log results to /var/log/update-qbit-port.log.


## Getting around CGNAT
There are a couple ways to get around CGNAT, mostly relying on a external server or 3rd party to point to your internal services.
I used the following approach making use of a VPS.

### Requirements:
- External server (VPS) w/ static public IP
- Domain name

### Steps:
1. Setup A records on domain pointing to VPS public IP:
- `jellyfin.mydomain.com`
- `jellyseerr.mydomain.com`
- ... Any other services you want accessible remotely.
2. Host a Wireguard sever on the VPS, setup a connection between home network and VPS.
3. Setup Nginx Proxy Manager on VPS. Add a proxy for each A record domain pointing to IP/Port of corresponding service.
