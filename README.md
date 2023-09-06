# celo-node

# System Requirements

- Atleast 4 GB RAM, 6 GB Recommended
- Atleast 256 GB SSD Storage (future-proofed for atleast 1 year)

## Firewall

Allow:

- 30303/udp
- 30303/tcp
- 443/tcp
- 80/tcp
 
## Setup

* This step assumes the setup is done on an Ubuntu/Debian based distro

After setting up the server:

```bash
apt update && apt upgrade --yes

# Install required pkg deps
apt install curl zstd aria2 chrony git

# Install Docker
curl -fsSL https://get.docker.com | bash
# To expose Docker Compose to PATH, add the below line to your .basrc or .profile
# export PATH="/usr/libexec/docker/cli-plugins:$PATH"

# Download using the snapshot below
aria2c -x 16 -s 16 $DOWNLOAD_LINK

# Clone this repo
git clone https://github.com/grassrootseconomics/celo-node.git

# Prepare directories
cd celo
docker network create celo
docker-compose up
# After a few seconds, cancel the operation with CTRL+C

# Extract and restore snapshot
tar --use-compress-program=unzstd -xvf chaindata-latest.tar.zst
# The data folder was created in the previous step when brining up the container
sudo rm -rf data/celo/chaindata
sudo mv chaindata data/celo

# Run the node
docker-compose up -d
# It may take a few minutes to sync up

# Check if the sync has completed
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545

# Update your domain in caddy/Caddyfile
cd ..
cd caddy
docker-compose up -d
# Your node should now be available at the endpoints configured
```

## License

[AGPL-3.0](LICENSE).

