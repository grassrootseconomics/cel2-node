#!/bin/sh
set -e

# Create JWT if it doesn't exist
if [ ! -f "/shared/jwt.txt" ]; then
  echo "Creating JWT..."
  mkdir -p /shared
  dd bs=1 count=32 if=/dev/urandom of=/dev/stdout | xxd -p -c 32 > /shared/jwt.txt
fi

if [ -n "$IPC_PATH" ]; then
  export EXTENDED_ARG="${EXTENDED_ARG:-} --ipcpath=$IPC_PATH"
fi

# Init genesis if it's a custom chain and the datadir is empty
if [ -n "${IS_CUSTOM_CHAIN}" ] && [ -z "$(ls -A "$BEDROCK_DATADIR")" ]; then
  echo "Initializing custom chain genesis..."
  geth init --datadir="$BEDROCK_DATADIR" /chainconfig/genesis.json
fi

# Determine syncmode based on NODE_TYPE
if [ -z "$OP_GETH__SYNCMODE" ]; then
  if [ "$NODE_TYPE" = "full" ]; then
    export OP_GETH__SYNCMODE="snap"
  else
    export OP_GETH__SYNCMODE="full"
  fi
fi

# Start op-geth.
exec geth \
  --datadir="$BEDROCK_DATADIR" \
  --http \
  --http.corsdomain="*" \
  --http.vhosts="*" \
  --http.addr=0.0.0.0 \
  --http.port=8545 \
  --http.api=web3,debug,eth,txpool,net,engine \
  --ws \
  --ws.addr=0.0.0.0 \
  --ws.port=8546 \
  --ws.origins="*" \
  --ws.api=debug,eth,txpool,net,engine,web3 \
  --syncmode="$OP_GETH__SYNCMODE" \
  --gcmode="$NODE_TYPE" \
  --authrpc.vhosts="*" \
  --authrpc.addr=0.0.0.0 \
  --authrpc.port=8551 \
  --authrpc.jwtsecret=/shared/jwt.txt \
  --rollup.sequencerhttp="$BEDROCK_SEQUENCER_HTTP" \
  --rollup.disabletxpoolgossip=true \
  --snapshot=true \
  --verbosity=4 \
  --history.transactions=0 \
  --bootnodes=enode://ac0f42fa46f8cc10bd02a103894d71d495537465133e7c442bc02dc76721a5f41761cc2d8c69e7ba1b33e14e28f516436864d3e0836e2dcdaf032387f72447dd@34.83.164.192:30303,enode://596002969b8b269a4fa34b4709b9600b64201e7d02e2f5f1350affd021b0cbda6ce2b913ebe24f0fb1edcf66b6c730a8a3b02cd940f4de995f73d3b290a0fc92@34.82.177.77:30303,enode://3619455064ef1ce667171bba1df80cfd4c097f018cf0205aaad496f0d509611b7c40396893d9e490ee390cd098888279e177a4d9bb09c58387bb0a6031d237f1@34.19.90.27:30303,enode://e3c54db6004a92d4ee87504f073f3234a25759b485274cc224037e3e5ee792f3b482c3f4fffcb764af6e1859a1aea9710b71e1991e32c1dee7f40352124bb182@35.233.249.87:30303,enode://674410b34fd54c8406a4f945292b96111688d4bab49aecdc34b4f1b346891f4673dcb03ed44c38ab467ef7bec0b20f6031ad88aa1d35ce1333b343d00fa19fb1@34.168.43.76:30303 \
  $EXTENDED_ARG $@
