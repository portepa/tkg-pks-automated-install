#!/bin/bash

set -ex
rm -rf helm-v3.1.0-linux-amd64.tar.gz && wget https://get.helm.sh/helm-v3.1.0-linux-amd64.tar.gz && tar -xvf helm-v3.1.0-linux-amd64.tar.gz 
#rm -rf helm-v2.16.3-linux-amd64.tar.gz && wget https://get.helm.sh/helm-v2.16.3-linux-amd64.tar.gz
rm -rf  sig-storage-local-static-provisioner && git clone --depth=1 https://github.com/kubernetes-sigs/sig-storage-local-static-provisioner.git

docker pull quay.io/external_storage/local-volume-provisioner:v2.3.4
docker save quay.io/external_storage/local-volume-provisioner:v2.3.4 -o local-volume-provisioner.tar

