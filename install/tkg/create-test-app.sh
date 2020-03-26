#!/bin/bash

docker load -i kuard.tar
kubectl create deployment kuard --image=gcr.io/kuar-demo/kuard-amd64:blue
kubectl create service clusterip kuard --tcp=8080:8080
kubectl get pods --all-namespaces
