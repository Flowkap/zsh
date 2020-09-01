#!/bin/bash
if [ -e ~/.kube/config ]; then echo $(cat ~/.kube/config | awk '/namespace:/{print $NF}' || echo 'default')@$(cat ~/.kube/config | awk '/current-context:/{print $NF}'); fi;
