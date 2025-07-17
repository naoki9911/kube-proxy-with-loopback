#!/bin/bash

CILIUM_VERSION="v1.17.5"
CILIUM_IMAGE="quay.io/cilium/cilium:${CILIUM_VERSION}"
CILIUM_OPERATOR_IMAGE="quay.io/cilium/operator-generic:${CILIUM_VERSION}"

function pull_and_load_cilium_images() {
    docker image pull $CILIUM_IMAGE
    docker image pull $CILIUM_OPERATOR_IMAGE
    kind load docker-image $CILIUM_IMAGE
    kind load docker-image $CILIUM_OPERATOR_IMAGE
}

function check_and_create_bridge() {
    BRIDGE_NAME=$1
    set +e
    ip lin show $BRIDGE_NAME
    RES=$?
    set -e

    if [ $RES -ne 0 ]; then
        sudo ip link add $BRIDGE_NAME type bridge
        sudo ip link set mtu 1500 dev $BRIDGE_NAME
        sudo ip link set up dev $BRIDGE_NAME
    fi
}
