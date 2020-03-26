#!/bin/bash

echo "#######################"
echo "Start kubeadm"


DEFAULT_GW=$(ip route show | grep default)
if [ -z "$DEFAULT_GW" ]
then  
  { printf "Default gateway not found!!!\nConsider adding one with: #ip route add default via 192.168.1.254
"; exit 1; }
fi


set -ex
# Dry-run kubeadm
kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.17.3+vmware.1 --image-repository=vmware.io --dry-run
# Run kubeadm for real
kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.17.3+vmware.1 --image-repository=vmware.io 

mkdir -p ~/.kube &&  cp /etc/kubernetes/admin.conf ~/.kube/config
# Remove taint from master so that it can schedule pods
kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl get nodes -w

