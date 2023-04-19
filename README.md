# celo-node

## Firewall

Allow:

- 30303/udp
- 30303/tcp
- 443/tcp
- 80/tcp
 

## Setup

### Snapshot Download links

- Mainnet: `https://storage.googleapis.com/celo-chain-backup/mainnet/chaindata-latest.tar.zst`
- Alfajores Tesnet: `https://storage.googleapis.com/celo-chain-backup/alfajores/chaindata-latest.tar.zst`

### Usage

1. Extract snapshot with  `tar --use-compress-program=unzstd -xvf chaindata-latest.tar.zst`
2. Bring up the `celo` container temporarily with `docker-compose up` and then exit.
3. Replace the chaindata (`./data/celo/chaindata`) folder with the snapshot `chaindata`.
4. Create a `celo` overlay network with `docker network create celo`
5. Bring up the `celo` container with `docker-compose up -d`.
6. Update `caddy/Caddyfile` and bring up the `caddy` container.


## License

[AGPL-3.0](LICENSE).

