#!/bin/bash

if [ -z "$PS1_CLUSTER" ]
then
    echo -e "You need to switch cluster first! (e.g. sc dev)";
    return;
fi

if [ -z "$1" ]
then
    echo Switching to NS=kube-system
    export TILLER_NAMESPACE="kube-system";
    kubectl config set-context --current --namespace=default;
    export PS1="$PS1_CLUSTER"
else
    echo Switching to NS=$1
    export TILLER_NAMESPACE="$1";
    kubectl config set-context --current --namespace=$1;
    export PS1="$1@$PS1_CLUSTER"
fi
