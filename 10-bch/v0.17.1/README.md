# Build Docker Images
Notice: if your server locaed in China, please check "Dockerfile" and uncomment some lines.
## Build by yourself
```
// mainnet
docker build -t bitcoin-cash:0.17.1 .

// testnet
docker build -t bitcoin-cash-testnet:0.17.1 -f testnet.Dockerfile .
```
## push to Aliyum docker hub
### login Aliyun docker hub
___replace word: yourname___
```
docker login --username=yourname@blockin registry.cn-beijing.aliyuncs.com

// mainnet
docker tag bitcoin-cash:0.17.1 registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.17.1
docker tag bitcoin-cash:0.17.1 registry.cn-hongkong.aliyuncs.com/poolin/bitcoin-cash:0.17.1

docker push registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.17.1
docker push registry.cn-hongkong.aliyuncs.com/poolin/bitcoin-cash:0.17.1
// testnet
docker tag bitcoin-cash-testnet:0.17.1 registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1
docker tag bitcoin-cash-testnet:0.17.1 registry.cn-hongkong.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1

docker push registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1
docker push registry.cn-hongkong.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1
```
# Config xcoin parameter
```
mkdir -p /work/config

// mainnet
cp docker_env_demo /work/config/docker_env_bch
vi /work/config/docker_env_bch

// testnet
cp docker_env_demo /work/config/docker_env_bch_testnet
vi /work/config/docker_env_bch_testnet
```
# Start Docker Container
## Built by yourself
```
// mainnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash \
-p 8331:8331 -p 8332:8332 -p 8333:8333 \
bitcoin-cash:0.17.1

// testnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch_testnet \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash-testnet \
-p 18331:18331 -p 18332:18332 -p 18333:18333 \
bitcoin-cash-testnet:0.17.1
```
## From Docker Hub
___replace word: yourname___
```
docker login --username=yourname@blockin registry.cn-beijing.aliyuncs.com

// mainnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash \
-p 8331:8331 -p 8332:8332 -p 8333:8333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.17.1

// mainnet while prot conflict
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash \
-p 28331:28331 -p 28332:28332 -p 28333:28333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.17.1

// testnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch_testnet \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash-testnet \
-p 18331:18331 -p 18332:18332 -p 18333:18333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1

// port confilict 
// mainnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash \
-p 28331:28331 -p 28332:28332 -p 28333:28333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.17.1

// testnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch_testnet \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash-testnet \
-p 38331:38331 -p 38332:38332 -p 38333:38333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1
```

# Dev cmds
## Login docker

```shell
docker exec -it bitcoin-cash bash
docker exec -it bitcoin-cash-testnet bash
```

## Check xcoind status

```shell
# check the xcoind log
tail -f /work/bitcoin-cashd/debug.log

# get xcoind container's IP
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)

# tail logs
docker logs --tail 50 --follow --timestamps bitcoin-cash
docker logs --tail 50 --follow --timestamps bitcoin-cash-testnet
```

## rpc cmds

### getnetworkinfo 

___replace word: username___  
___replace word: password___  
___replace word: dockerip___  
___replace word: port___  

```
curl --user username:password --data-binary '{"jsonrpc":"1.0","id":"1","method":"getnetworkinfo","params":[]}' -H 'content-type:text/plain;' http://dockerip:port -i
```
### getblocktemplate
___replace word: username___  
___replace word: password___  
___replace word: dockerip___  
___replace word: port___  
```
curl --user username:password --data-binary '{"jsonrpc":"1.0","id":"1","method":"getblocktemplate","params":[]}' -H 'content-type:text/plain;' http://dockerip:port -i
```
