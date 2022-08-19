#!/bin/sh

set -eux

#URL=https://raw.githubusercontent.com/otter-sec/solana-setup/main/Dockerfile
URL=~/solana-setup

docker build $URL

docker run --network host \
  -v $(pwd):/work \
  -u $(id -u ${USER}):$(id -g ${USER}) \
  -it \
  $(docker build -q $URL) /bin/bash
