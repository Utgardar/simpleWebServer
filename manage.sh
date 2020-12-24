#!/usr/bin/env bash
# set -x

start ()
{
    echo "Create namespaces where run applications"
    kubectl create namespace nginx-ingress
    kubectl create namespace simplewebserver

    echo "Setup ingress-nginx repository for helm"
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    echo "Setup ingress-nginx into k8s cluster"
    helm upgrade nginx-ingress ingress-nginx/ingress-nginx --namespace nginx-ingress -i --set controller.publishService.enabled=true
    echo "Waiting for nginx-ingress to finish initialization..."
    sleep 10
    echo "Setup our application into k8s cluster"
    helm upgrade simplewebserver ./helm/simplewebserver --namespace simplewebserver -i -f ./helm/simplewebserver/values.yaml
}

stop ()
{
    helm delete --namespace simplewebserver simplewebserver
    helm delete --namespace nginx-ingress nginx-ingress
}

case $1 in
start)
    start
    ;;
stop)
    stop
    ;;
*)
    echo "Howto run app: $0 (start|stop)"
esac
