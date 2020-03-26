#!/bin/bash

set -ex

wget http://archive.ubuntu.com/ubuntu/pool/main/s/socat/socat_1.7.3.2-2ubuntu2_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/containerd.io_1.2.6-3_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce-cli_19.03.6\~3-0\~debian-buster_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_19.03.6\~3-0\~debian-buster_amd64.deb
wget https://downloads.heptio.com/vmware-tanzu-kubernetes-grid/523a448aa3e9a0ef93ff892dceefee0a/vmware-kubernetes-v1.17.3%2Bvmware.1.tar.gz


docker pull gcr.io/kuar-demo/kuard-amd64:blue
docker save gcr.io/kuar-demo/kuard-amd64:blue -o kuard.tar

#Calico
wget https://docs.projectcalico.org/v3.11/manifests/calico.yaml
docker pull calico/cni:v3.11.2
docker save calico/cni:v3.11.2 -o calico-cni.tar
docker pull  calico/pod2daemon-flexvol:v3.11.2
docker save calico/pod2daemon-flexvol:v3.11.2 -o calico-pod2daemon.tar
docker pull calico/node:v3.11.2
docker save calico/node:v3.11.2 -o calico-node.tar
docker pull calico/kube-controllers:v3.11.2
docker save calico/kube-controllers:v3.11.2 -o calico-kube-controller.tar
docker pull calico/ctl:v3.11.0
docker save calico/ctl:v3.11.0 -o calico-ctl.tar 

#Flannel

wget https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
docker pull quay.io/coreos/flannel:v0.11.0-amd64
docker save quay.io/coreos/flannel:v0.11.0-amd64 -o flannel-v0.11.0-amd64.tar
