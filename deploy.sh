#!/bin/bash

set -eux

cd $(dirname $0)

. ./version.sh

kind create cluster --config kind-config.yaml --image kindest/node:v1.33.1
pull_and_load_cilium_images
sudo containerlab deploy -t ipclos.clab.yaml

cilium install --version $CILIUM_VERSION --values values.yaml
cilium status --wait
kubectl apply -f manifests/cilium-bgp.yaml

