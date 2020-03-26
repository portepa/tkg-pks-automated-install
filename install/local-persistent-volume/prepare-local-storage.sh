#!/bin/bash

set -ex

#tar -xvf helm-v2.16.3-linux-amd64.tar.gz 
tar -xvf helm-v3.1.0-linux-amd64.tar.gz && chmod +x linux-amd64/helm && cp linux-amd64/helm /usr/local/bin 

docker load -i local-volume-provisioner.tar  
docker tag quay.io/external_storage/local-volume-provisioner:v2.3.4 vmware.io/local-volume-provisioner:v2.3.4

./linux-amd64/helm template ./sig-storage-local-static-provisioner/helm/provisioner -f values.yaml>local-volume-provisioner.generated.yaml
sed -i 's/quay.io\/external_storage\/local-volume-provisioner:v2.3.4/vmware.io\/local-volume-provisioner:v2.3.4/g'  local-volume-provisioner.generated.yaml 

kubectl create -f local-volume-provisioner.generated.yaml

mkdir -p /usr/local/docker/vol1
sed -i "s/ubuntu/$(kubectl get nodes -o name | sed 's/node\///')/g" pv.yaml
kubectl create -f pv.yaml
kubectl create -f pvc.yaml

