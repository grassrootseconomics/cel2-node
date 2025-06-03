if [ ! -f "./shared/jwt.txt" ]; then
  echo "Creating shared JWT..."
  mkdir -p shared
  dd bs=1 count=32 if=/dev/urandom of=/dev/stdout | xxd -p -c 32 > ./shared/jwt.txt
fi

mkdir -p data

if [ -n "${CHAIN:-mainnet}" ] && [ -z "$(ls -A data)" ]; then
  echo "Initializing custom chain genesis..."
  if [ ! -f ./chains/"${CHAIN:-mainnet}"/genesis.json ]; then
    echo "Missing "${CHAIN:-mainnet}" genesis.json file"
    exit
  fi
  docker run --rm -v $(pwd)/data:/geth -v $(pwd)/chains/${CHAIN:-mainnet}:/chainconfig ${GETH_IMAGE:-us-west1-docker.pkg.dev/devopsre/celo-blockchain-public/op-geth:celo-v2.0.4} init --datadir=/geth /chainconfig/genesis.json
fi