#!/bin/sh
set -e

# Start op-node.
exec op-node \
  --l1=https://ethereum-holesky-rpc.publicnode.com \
  --l2=http://op-geth:8551 \
  --rpc.addr=0.0.0.0 \
  --rpc.port=9545 \
  --l2.jwt-secret=/shared/jwt.txt \
  --l1.trustrpc \
  --l1.rpckind=basic \
  --l1.beacon=https://ethereum-holesky-beacon-api.publicnode.com \
  --syncmode=execution-layer \
  --p2p.priv.path=/shared/op-node_p2p_priv.txt \
  --rollup.config=/chainconfig/rollup.json \
  --p2p.static=/ip4/35.197.25.52/tcp/9222/p2p/16Uiu2HAmQEdyLRSAVZDr5SqbJ1RnKmNDhtQJcEKmemrVxe4FxKwR,/ip4/34.105.22.4/tcp/9222/p2p/16Uiu2HAm1SZBDSugT5MMu7vBY8auDgfZFNhoDeXPLc9Me5FsAxwT,/ip4/34.83.209.168/tcp/9222/p2p/16Uiu2HAmGJAiUX6HLSo4nLh8T984qxzokwL23cVsYuNZy2SrK7C6,/ip4/34.83.214.149/tcp/9222/p2p/16Uiu2HAmAko2Kr3eAjM7tnshtEhYrxQYfKUvN2kwiygeFoBAoi8S,/ip4/34.169.5.52/tcp/9222/p2p/16Uiu2HAmKc6YKHzYgsjBDaj36uAufxpgZFgrzDqVBt6zTPwdhhJD \
  --altda.enabled=true \
  --altda.da-server=https://eigenda-proxy.alfajores.celo-testnet.org \
  --altda.da-service=true \
  --altda.verify-on-read=false