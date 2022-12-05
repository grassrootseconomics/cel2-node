# docker-compose up
# docker-compose down

wget https://storage.googleapis.com/celo-chain-backup/alfajores/chaindata-latest.tar.gz && \
tar -xzf chaindata-latest.tar.gz && \
mv chaindata data/celo
