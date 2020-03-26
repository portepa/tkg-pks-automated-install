#!/bin/bash

source images.sh

for image in "${image_list[@]}"; do
    echo "Importing ${image}";
    docker load -i "$(echo $image | sed 's/^.*\///' | sed 's/:.*$//').tar"
done

mkdir -p /usr/local/docker/vol2
mkdir -p /usr/local/docker/vol3

sed -i "s/ubuntu/$(kubectl get nodes -o name | sed 's/node\///')/g" pv-prometheus-server.yaml
sed -i "s/ubuntu/$(kubectl get nodes -o name | sed 's/node\///')/g" pv-alertmanager.yaml


kubectl apply -f pv-prometheus-server.yaml
kubectl apply -f pv-alertmanager.yaml 

helm install prometheus prometheus-11.0.0.tgz
helm install grafana grafana-5.0.4.tgz 
