#!/bin/bash


source images.sh

docker tag docker.io/projectcontour/contour:v1.2.0 docker.io/projectcontour/contour:latest

for image in "${image_list[@]}"; do
   echo "Downloaing ${image}";
   docker load -i "$(echo $image | sed 's/^.*\///' | sed 's/:.*$//').tar"
done

kubectl apply -f contour.yaml

ufw allow 80/tcp

NS=contour-test
kubectl create namespace $NS
kubectl create deployment kuard --image=gcr.io/kuar-demo/kuard-amd64:blue -n $NS
kubectl create service clusterip kuard --tcp=8080:8080 -n $NS
kubectl apply -f httproxy.yaml -n $NS

echo "127.0.0.1 foo-basic.bar.com" >>/etc/hosts


curl -v foo-basic.bar.com
