#!/usr/bin/env bash
# set -x

start ()
{
    multipass launch --name simplewebserver --cpus 4 --mem 4g --disk 20g
    multipass mount ${PWD} simplewebserver:/home/ubuntu/simplewebserver
    multipass exec simplewebserver -- bash -c "sudo /home/ubuntu/simplewebserver/manage.sh install"
}

start-k8s ()
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

install ()
{
    apt update && apt -y install ansible
    ansible-playbook /home/ubuntu/simplewebserver/ansible/nginx.yml
}

stop ()
{
    multipass umount simplewebserver
    multipass stop simplewebserver
    multipass delete simplewebserver
    multipass purge
}

stop-k8s ()
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
start-k8s)
    start-k8s
    ;;
stop-k8s)
    stop-k8s
    ;;
install)
    install
    ;;
*)
    echo "Howto run app: $0 (start|stop)"
esac
