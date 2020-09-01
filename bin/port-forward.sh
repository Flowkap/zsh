#!/bin/bash

if [[ -z "$1" ]]
then
    echo "You need to specify a service to forward!"
    echo "Usage:"
    echo "  port-forward <service>"
    return;
fi

# different ports used to prevent same host/port cache problems
export PROTO=http
case "$1" in
    "kubernetes")
        #chrome://flags/#allow-insecure-localhost required for chrome / chromium
        export PORT=9204; export PROTO=https; kubectl port-forward svc/kubernetes-dashboard -n kubernetes-dashboard $PORT:443 &;;
    "grafana")
        export PORT=9200; kubectl port-forward svc/prometheus-operator-grafana -n default $PORT:80 &;;
    "keycloak")
        export PORT=9201; kubectl port-forward svc/keycloak-http -n default $PORT:80 &;;
    "kibana")
        export PORT=9202; kubectl port-forward svc/kibana -n default $PORT:443 &;;
    "rabbitmq")
        export PORT=9203; kubectl port-forward svc/broker-rabbitmq-ha -n default $PORT:15672 &;;
    "prometheus")
        export PORT=9205; kubectl port-forward svc/prometheus-operator-prometheus -n default $PORT:9090 &;;
    "alertmanager")
        export PORT=9206; kubectl port-forward svc/prometheus-operator-alertmanager -n default $PORT:9090 &;;
    "pgo")
        export PORT=9207; kubectl port-forward svc/postgres-operator-ui -n default $PORT:80 &;;

    # non UI services
    "broker")
        export PROTO=none; kubectl port-forward svc/broker-rabbitmq-ha -n default 5672:5672 &;;
    "mongodb")
        export PROTO=none; kubectl port-forward svc/mongodb -n default 27017:27017 &;;
    "postgres")
        export PROTO=none; kubectl port-forward svc/postgres-stolon-proxy -n default 5432:5432 &;;
esac

if [[ "$PROTO" == "http" || "$PROTO" == "https" ]]
then
    export APP_PID=$!
    echo $APP_PID
    sleep 4s
    google-chrome $PROTO://localhost:$PORT
    read -p "Press any key to cancel port forward"
    kill $APP_PID
fi
