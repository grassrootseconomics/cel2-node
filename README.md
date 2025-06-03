# cel2-node

> For CELO Pre-fork (< January 2025), refer to the `celo-old` branch

## CEL2 Mainnet System Requirements

- Atleast 16 GB RAM
- Atleast 1TB SSD Storage (As of June 2025)

## Features

- Snap sync by default
- ENV only configuration for easier management
- Metrics server is always enabled (InfluxDB push disabled)
- Optional OTEL collector for pull-based metrics aggregation (Lighter than InfluxDB stack)
- Reconfigured OP stack to retain more peers to prioritize liveness

## Firewall

Allow:

- 30303/udp
- 30303/tcp
- 9222/udp
- 9222/tcp
- 443/tcp
- 80/tcp

## Setup

- This step assumes the setup is done on an Ubuntu/Debian based distro

After setting up the server:

```bash
apt update && apt upgrade --yes

# Install required pkg deps
apt install curl chrony git xxd

# Install Docker
curl -fsSL https://get.docker.com | bash

# Clone this repo
git clone https://github.com/grassrootseconomics/cel2-node.git

# Prepare directories
cd cel2
docker network create cel2

# Bootstrap genesis data
# For Alfajores, set $CHAIN=alfajores
./bootstrap.sh

# Update all .env files with your own settings
# For Alfajores, configs are commented out. Also update docker-compose.yaml
vi op-geth.env
vi op-node.env
vi eigenda-proxy.env

# Start OP stack
docker compose up -d

# Check if the sync has completed
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545

# Update your domain in caddy/Caddyfile
cd ..
cd caddy
docker compose up -d
# Your node should now be available at the endpoints configured

# OTEL
# See metrics folder
```

## License

[LGPL](LICENSE).
