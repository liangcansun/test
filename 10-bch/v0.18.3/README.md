# Build Docker Images

```shell
# build 
docker build -t bitcoin-cash:0.18.3 .
```

# Push To Aliyun Docker Hub
___replace word: yourname___

```shell
# login
docker login --username=yourname@blockin registry.cn-beijing.aliyuncs.com

## mainnet
# tag
docker tag bitcoin-cash:0.18.3 registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.18.3
docker tag bitcoin-cash:0.18.3 registry.cn-hongkong.aliyuncs.com/poolin/bitcoin-cash:0.18.3
# push
docker push registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.18.3
docker push registry.cn-hongkong.aliyuncs.com/poolin/bitcoin-cash:0.18.3
```

# Set Config File

```shell
# mkdir for bitcoin-cash
mkdir -p /work/config
# mainnet
cp docker_env_demo /work/config/docker_env_btc
vi /work/config/docker_env_btc
XCOIN_TESTNET=false

# testnet
cp docker_env_demo /work/config/docker_env_btc_testnet
vi /work/config/docker_env_btc_testnet
XCOIN_TESTNET=true
```

# Start Docker Container
```shell

# start mainnet docker
docker run --env-file /work/config/docker_env_btc \
--dns 8.8.8.8 \
-v /work/bitcoin-cash:/root/.bitcoin \
--name bitcoin-cash --restart always \
-p 8331:8331 -p 8332:8332 -p 8333:8333 \
-d registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.18.3

# start testnet docker
docker run --env-file /work/config/docker_env_btc_testnet \
--dns 8.8.8.8 \
-v /work/bitcoin-cash-testnet:/root/.bitcoin \
--name bitcoin-cash-testnet --restart always \
-p 18331:18331 -p 18332:18332 -p 18333:18333 \
-d registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.18.3
```

## Dev Cmds

### Login Docker

```shell
docker exec -it bitcoin-cash /bin/bash
docker exec -it bitcoin-cash-testnet /bin/bash
```

### Check Xcoind Status

```shell
# check the xcoind log
tail -f /work/bitcoin-cash/debug.log

# tail logs
docker logs --tail 50 --follow --timestamps bitcoin-cash
docker logs --tail 50 --follow --timestamps bitcoin-cash-testnet

# get xcoind container's IP
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
```

## RPC Cmds

### getnetworkinfo

___replace word: rpcuser___

___replace word: rpcpassword___

___replace word: dockerip, default:localhost___

___replace word: port, default:8332___

```shell
## While dogecoind started.节点正在同步时可能会hang住RPC端口。
curl -u rpcuser:rpcpassword \
--basic -X POST \
-d '{"jsonrpc":"2.0","id":"0","method":"getnetworkinfo"}' \
-H 'Content-Type: application/json' "http://localhost:8332"
```

### getblocktemplate

___replace word: rpcuser___

___replace word: rpcpassword___

___replace word: dockerip, default:localhost___

___replace word: port, default:8332___

```shell
## After dogecoind fulfilled synchronously.节点数据同步完成后测试。
curl -u rpcuser:rpcpassword \
--basic -X POST \
-d '{"jsonrpc":"2.0",
     "id":"0",
     "method":"getblocktemplate",
     "params":[{"wallet_address":"A7HRQk3GFCW2QasvdZxXuYj8kkQK5QrYLs","reserve_size":8}]}' \
-H 'Content-Type: application/json' "http://localhost:8332"
```

```
curl -X "POST" "http://localhost:8332" \
     -H 'Content-Type: text/plain; charset=utf-8' \
     -u 'rpcuser:rpcpassword' \
     -d $'{"method": "getrawtransaction", "params": ["7301b595279ece985f0c415e420e425451fcf7f684fcce087ba14d10ffec1121", 1], "id": "1"}'
```
