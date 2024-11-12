# cel2-node

> For CELO Pre-fork (< January 2025), refer to the `celo-old` branch

# Alfajores System Requirements

- Atleast 12 GB RAM, 16 GB Recommended
- Atleast 512 GB SSD Storage (As of November 2024)

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
apt install curl chrony git

# Install Docker
curl -fsSL https://get.docker.com | bash

# Clone this repo
git clone https://github.com/grassrootseconomics/cel2-node.git

# Prepare directories
cd cel2
docker network create cel2

# Download chaindatasnapshot
aria2c -x 16 -s 16 https://storage.googleapis.com/cel2-rollup-files/alfajores/alfajores-migrated-datadir.tar.zst
mkdir -p cel2-chaindata/
tar -xvf alfajores-migrated-datadir.tar.zst -C cel2-chaindata/

# Start OP Geth
docker compose up cel2-op-geth

# Start OP Node
cp cel2-chaindata/jwt.hex cel2-rollupdata/jwt.hex
docker compose up cel2-op-node

# Check if the sync has completed
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545

# Update your domain in caddy/Caddyfile
cd ..
cd caddy
docker compose up -d
# Your node should now be available at the endpoints configured
```

## License

[MIT](LICENSE).
