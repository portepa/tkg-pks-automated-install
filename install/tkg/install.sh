#!/bin/bash
set -ex

TKG_FOLDER=vmware-kubernetes-v1.17.3+vmware.1
TKG_FILE=${TKG_FOLDER}.tar.gz
TARGET=/opt/tkg/${TKG_FOLDER}

#Create installation folder
mkdir -p /opt/tkg
cp ${TKG_FILE} /opt/tkg/

#Dependencies
dpkg -i socat_1.7.3.2-2ubuntu2_amd64.deb containerd.io_1.2.6-3_amd64.deb docker-ce-cli_19.03.6~3-0~debian-buster_amd64.deb docker-ce_19.03.6~3-0~debian-buster_amd64.deb

#Sytemctl enable docker calls prepares the socket
systemctl enable docker

tar -xzf ${TKG_FILE} -C /opt/tkg

for p in "${TARGET}/debs/*"; do
  echo "Installing package: $p\n"
  dpkg -i  $p
done


echo "############################"
echo "Import images to docker"


K8S_VERSION=v1.17.3 
ETCD_VERSION=v3.4.3
COREDNS_VERSION=v1.6.5
COREDNS_FIXED_VERSION=$(sed 's/v//g' <<< $COREDNS_VERSION) #Fixes CoreDNS name for standard manifest
ETCD_FIXED_VERSION=$(sed 's/v//g' <<< $ETCD_VERSION) #Fixes etcd name for standard manifest

declare -a image_list=("${TARGET}/kubernetes-${K8S_VERSION}+vmware.1/images/kube-proxy-${K8S_VERSION}_vmware.1.tar.gz"
                       "${TARGET}/kubernetes-${K8S_VERSION}+vmware.1/images/kube-apiserver-${K8S_VERSION}_vmware.1.tar.gz"
                       "${TARGET}/kubernetes-${K8S_VERSION}+vmware.1/images/kube-controller-manager-${K8S_VERSION}_vmware.1.tar.gz"
                       "${TARGET}/kubernetes-${K8S_VERSION}+vmware.1/images/kube-scheduler-${K8S_VERSION}_vmware.1.tar.gz"
                       "${TARGET}/kubernetes-${K8S_VERSION}+vmware.1/images/pause-3.1.tar.gz"
                       "${TARGET}/etcd-${ETCD_VERSION}+vmware.3/images/etcd-${ETCD_VERSION}_vmware.3.tar.gz"
                       "${TARGET}/coredns-${COREDNS_VERSION}+vmware.3/images/coredns-${COREDNS_VERSION}_vmware.3.tar.gz")


for image in "${image_list[@]}"; do
    echo "Importing ${image}";
    gunzip -c  $image | docker load;
done

#Update the CoreDNS image so the default kubeadm manifests pick them up
docker tag vmware.io/coredns:${COREDNS_VERSION}_vmware.3 vmware.io/coredns:${COREDNS_FIXED_VERSION}
docker tag vmware.io/etcd:${ETCD_VERSION}_vmware.3 vmware.io/etcd:${ETCD_FIXED_VERSION}
docker tag vmware.io/etcd:${ETCD_VERSION}_vmware.3 vmware.io/etcd:${ETCD_FIXED_VERSION}-0


# Permanent turn off swapping
swapoff -a
sed -i 's/^\(.*swap.*\)$/#\1/g' /etc/fstab

echo "#######################"
echo "Prepare kubelet"
systemctl enable kubelet

