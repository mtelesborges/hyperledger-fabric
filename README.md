- Links de referência

https://github.com/deusimarferreira/hyperledger-fabric/tree/master
https://github.com/blockchainempresarial/curso-hyperledger-fabric/tree/master
[Golang](https://hub.docker.com/_/golang)

- Instalar as dependências
```sh
# curl: necessário para download do script de instalação dos binários de Hyperledger Fabric
# bash: necessário para a execução do script
# gcompat: necessário para a execução dos binários .+yrBscU9KYAKm*
apk add curl bash gcompat
```

- Baixar e fornecer permissão de execução do script de instalação dos binários
```sh
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
```

- Instalação dos binários
```sh
# Os binários devem estar configurados em um diretório global
# Como prática comum na comunidade golang, o diretório deve ser $HOME/go/src/github.com/<id do repositório no github>
cd $HOME/go/src/github.com/gca-research-group
bash ./install-fabric.sh binary
```

- Adicionar os arquivo no path global
```sh
export PATH="$PATH:$HOME/go/src/github.com/gca-research-group/bin"
```

- Criar crypto-config.yaml

- Gerar os arquivos criptográficos da rede
```sh
cryptogen generate --config=./crypto-config.yaml
```

- Criar configtx.yaml

- Gerar o bloco genesis
```sh
# Necessário criar o arquivo configtx.yaml com as respectivas configurações
configtxgen -profile ThreeOrgsOrdererGenesis -channelID system-channel -outputBlock ./channel-artifacts/genesis.block
configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID marketplace
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID marketplace -asOrg Org1MSP
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID marketplace -asOrg Org2MSP
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID marketplace -asOrg Org3MSP
```

- Configurar canal
```sh
export CHANNEL_NAME=marketplace
peer channel create -o orderer.gca.edu.br:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/gca.edu.br/orderers/orderer.gca.edu.br/msp/tlscacerts/tlsca.gca.edu.br-cert.pem
```

- Adicionar organizações ao canal
```sh
peer channel join -b marketplace.block
```