#!/bin/bash

#Calico

mkdir -p /opt/calico && cp -rf ./calico* /opt/calico

docker load -i /opt/calico/calico-cni.tar
docker load -i /opt/calico/calico-pod2daemon.tar
docker load -i /opt/calico/calico-kube-controller.tar
docker load -i /opt/calico/calico-node.tar

kubectl apply -f /opt/calico/calico.yaml

kubectl get nodes --all-namespaces -w
