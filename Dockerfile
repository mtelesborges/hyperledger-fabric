FROM golang:1.20.6-alpine3.18

RUN apk add curl bash gcompat

RUN mkdir -p $HOME/go/src/github.com/gca-research-group

RUN export PATH="$PATH:$HOME/go/src/github.com/gca-research-group/bin"

RUN cd $HOME/go/src/github.com/gca-research-group

RUN curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh

RUN bash ./install-fabric.sh binary
