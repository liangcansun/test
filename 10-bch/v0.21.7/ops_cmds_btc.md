# start docker
___replace word: yourname___
```
docker login --username=yourname@blockin registry.cn-beijing.aliyuncs.com

// mainnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_zcash \
-v /work/zcashd:/root/.zcash \
--name zcashd-1.1.0 \
-p 8231:8231 -p 8232:8232 -p 8233:8233 \
registry.cn-beijing.aliyuncs.com/poolin/zcashd:1.1.0

// testnet
docker run -it --restart always -d \
--env-file /work/config/docker_env_zcash_testnet \
-v /work/zcashd:/root/.zcash \
--name zcashd-testnet-1.1.0 \
-p 18231:18231 -p 18232:18232 -p 18233:18233 \
registry.cn-beijing.aliyuncs.com/poolin/zcashd-testnet:1.1.0
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
curl --user username:password --data-binary '{"jsonrpc":"1.0","id":"1","method":"getblocktemplate","params":[{"rules":["segwit"]}]}' -H 'content-type:text/plain;' http://dockerip:port -i
```