# start docker
___replace word: yourname___
```
docker login --username=yourname@blockin registry.cn-beijing.aliyuncs.com

// mainnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash-0.17.1 \
-p 8331:8331 -p 8332:8332 -p 8333:8333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash:0.17.1

// testnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_bch_testnet \
-v /work/bitcoin-cashd:/root/.bitcoin \
--name bitcoin-cash-testnet-0.17.1 \
-p 18331:18331 -p 18332:18332 -p 18333:18333 \
registry.cn-beijing.aliyuncs.com/poolin/bitcoin-cash-testnet:0.17.1

```
# getnetworkinfo 
___replace word: username___  
___replace word: password___  
___replace word: dockerip___  
___replace word: port___  
```
curl --user username:password --data-binary '{"jsonrpc":"1.0","id":"1","method":"getnetworkinfo","params":[]}' -H 'content-type:text/plain;' http://dockerip:port -i
```
# getblocktemplate
___replace word: username___  
___replace word: password___  
___replace word: dockerip___  
___replace word: port___  
```
curl --user username:password --data-binary '{"jsonrpc":"1.0","id":"1","method":"getblocktemplate","params":[]}' -H 'content-type:text/plain;' http://dockerip:port -i
```