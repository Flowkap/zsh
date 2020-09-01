#!/bin/bash
pushd ~/.kube

if [ -z "$PS1_ORG" ]
then
    export PS1_ORG="$PS1"
fi

if [ -z "$1" ]
then
    rm config
    echo "Disconnected kubectl from any cluster"
    unset PS1_CLUSTER
    export PS1="$PS1_ORG"
else
    cp $1 config
    kubectl cluster-info
    export PS1="$1-cluster $PS1_ORG"
    export PS1_CLUSTER="$1-cluster $PS1_ORG"
fi

popd
