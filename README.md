# ServarrStack
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
- `proton.env` - Proton VPN credentials. TODO: Change variables to actual
  ```sh
  WIREGUARD_PUBLIC_KEY=123
  WIREGUARD_IP=10.0.0.1
  ```
- `qbit.env` - qBittorrent credentials.
  ```sh
  QBIT_USER=admin
  QBIT_PASS=admin
  ```
- `wg-private.key` - Wireguard private key
- `wg-public.key` - Wireguard public key
4. Run the following command to start the services:
    ```sh
    docker-compose up -d
    ```
