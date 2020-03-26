# TKG Install

## Link to download binaries

https://drive.google.com/drive/folders/13JVOsOuGNfR3oTFUHjYOizDCYWvWahV4?usp=sharing

## Install Ubuntu 18.04 OS on the physical server using ILO

## Get ubuntu password 

## Enable SSH access

## Ensure ubuntu has sudo access

## Connect the USB hardrive to the laptop

## Then SCP  from the laptop to the ubuntu server
scp debs.tar.gz ubuntu@IP:

scp docker_images.tar.gz ubuntu@IP:

scp yaml.tar.gz ubuntu@IP:

## Connect to  the ubuntu server through SSH
ssh ubuntu@IP

## Extract the debs package to install
tar xzvf debs.tar.gz 

## Change directory to the new extracted folder
cd debs

## Install all the debs package needed
sudo dpkg -i *.deb

## add ubuntu as a docker user
sudo usermod -aG docker ubuntu

## exit the SSH and connect again
exit

ssh ubuntu@IP

## check with a docker command
docker ps

## unzip docker images
gunzip docker_images.tar.gz

## load docker images
docker load -i docker_images.tar

## check with docker command
docker images

## init kube
sudo kubeadm init --image-repository vmware.io 

## Enable kubelet on reboot
sudo systemctl enable kubelet.service

## configure kubectl
mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "alias k=kubectl" >> ~/.bashrc

source ~/.bashrc


## remove taint on master
kubectl taint node ip-172-31-11-113  node-role.kubernetes.io/master:NoSchedule-

## Extract the yaml file to deploy
tar xzvf yanl.tar.gz 

## Install the yaml files
kubectl apply -f yanl/

## check everything
kubectl get no

kubectl get po -A
