# Build Docker Images

```shell
# build 
docker build -t bch-abc:0.20.2 .
```

# Push To Aliyun Docker Hub
___replace word: yourname___

```shell
# login
docker login --username=yourname@blockin registry.cn-beijing.aliyuncs.com
docker login --username=yourname@blockin registry.cn-hongkong.aliyuncs.com
docker login --username=yourname@blockin registry.us-east-1.aliyuncs.com

## mainnet
# tag
docker tag bch-abc:0.20.2 registry.cn-beijing.aliyuncs.com/poolin/bch-abc:0.20.2
docker tag bch-abc:0.20.2 registry.cn-hongkong.aliyuncs.com/poolin/bch-abc:0.20.2
docker tag bch-abc:0.20.2 registry.us-east-1.aliyuncs.com/poolin/bch-abc:0.20.2

# push
docker push registry.cn-beijing.aliyuncs.com/poolin/bch-abc:0.20.2
docker push registry.cn-hongkong.aliyuncs.com/poolin/bch-abc:0.20.2
docker push registry.us-east-1.aliyuncs.com/poolin/bch-abc:0.20.2
```

# Set Config File

```shell
# mkdir for bitcoind
mkdir -p /work/config
# mainnet
cp docker_env_demo /work/config/docker_env_bch
vi /work/config/docker_env_bch
XCOIN_TESTNET=false

# testnet
cp docker_env_demo /work/config/docker_env_bch_testnet
vi /work/config/docker_env_bch_testnet
XCOIN_TESTNET=true
```

# Start Docker Container
```shell
# start mainnet docker
docker run --env-file /work/config/docker_env_bch_abc \
--dns 8.8.8.8 \
--dns 119.29.29.19 \
--dns 182.254.116.116 \
--dns 114.114.114.114 \
--dns 114.114.114.115 \
-v /work/bch-abc:/root/.bitcoin \
--name bch-abc --restart always \
-p 8331:8331 -p 8332:8332 -p 8333:8333 \
-d registry.cn-beijing.aliyuncs.com/poolin/bch-abc:0.20.2

# start testnet docker
docker run --env-file /work/config/docker_env_bch_abc_testnet \
--dns 8.8.8.8 \
--dns 119.29.29.19 \
--dns 182.254.116.116 \
--dns 114.114.114.114 \
--dns 114.114.114.115 \
-v /work/bch-abc-testnet:/root/.bitcoin \
--name bch-abc-testnet --restart always \
-p 18331:18331 -p 18332:18332 -p 18333:18333 \
-d registry.cn-beijing.aliyuncs.com/poolin/bch-abc:0.20.2

# port conflict
# start mainnet docker
docker run --env-file /work/config/docker_env_bch_abc \
--dns 8.8.8.8 \
--dns 119.29.29.19 \
--dns 182.254.116.116 \
--dns 114.114.114.114 \
--dns 114.114.114.115 \
-v /work/bch-abc:/root/.bitcoin \
--name bch-abc --restart always \
-p 28331:8331 -p 28332:8332 -p 28333:8333 \
-d registry.cn-beijing.aliyuncs.com/poolin/bch-abc:0.20.2

# start testnet docker
docker run --env-file /work/config/docker_env_bch_abc_testnet \
--dns 8.8.8.8 \
--dns 119.29.29.19 \
--dns 182.254.116.116 \
--dns 114.114.114.114 \
--dns 114.114.114.115 \
-v /work/bch-abc-testnet:/root/.bitcoin \
--name bch-abc-testnet --restart always \
-p 38331:18331 -p 38332:18332 -p 38333:18333 \
-d registry.cn-beijing.aliyuncs.com/poolin/bch-abc:0.20.2
```

## Dev Cmds

### Login Docker

```shell
docker exec -it bch-abc /bin/bash
docker exec -it bch-abc-testnet /bin/bash
```

### Check Xcoind Status

```shell
# check the xcoind log
tail -f /work/bitcoind/debug.log

# tail logs
docker logs --tail 50 --follow --timestamps bitcoind
docker logs --tail 50 --follow --timestamps bitcoind-testnet

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

```
bitcoin-cli getblockcount
bitcoin-cli getblocktemplate
```

