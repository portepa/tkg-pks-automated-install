#!/bin/bash
set -ex

sysctl net.bridge.bridge-nf-call-iptables=1

mkdir -p /opt/flannel && cp -rf ./*flannel* /opt/flannel

docker load -i /opt/flannel/flannel-v0.11.0-amd64.tar

kubectl apply -f /opt/flannel/kube-flannel.yml

kubectl get nodes -w
