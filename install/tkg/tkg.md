## 0) Get TKG binaries

Run download-deps.sh to get TKG and all of its dependencies:
- Deb: socat
- Deb: Docker(containerd,cli,docker ce)
- Binary: TKG signed binaries (including contrainer images, debs, rpms)
- Container images: Calico, Flannel, Kuard (test app [kuard](https://github.com/kubernetes-up-and-running kuard) )


## 1) Copy binaries 
If remote access from the machine to target is possible,
 ``` scp -i ~/.ssh/key *  ubuntu@$HOST:~ ```
Otherwise copy the top repo folder onto a usb, and then plug in to target notebook.

 ## 2) Install dependencies
Run ```install.sh``` script to:
- install debian packages
- enable systemd service for docker & kubelet
- import container images with the right tag

This script assumes that all required binaries are downloaded and in the same folder as `install.sh` script.

## 3) Run kubeadm

Run ```run-kubeadm.sh``` script to start a kubeadm based installation.

When script finishes, nodes will be listed via  ```kubectl get nodes -w``` command.

The nodes will be in _NotReady+ state due to CNI not being ready. Next step is installing a CNI plugin.

## 4) Install CNI

Calico will be installed by running the ```./install-calico.sh``` script.
Calico container images and kubernetes manifests are available on the node and they are applied to kubernetes.
After this step run ```kubectl get nodes -w``` command again, node(s) should transition to _Ready_ state.

## 5) Install test application

Run ```create-test-app.sh``` to creata an example app:kuard. 

Assuming there are not LB's available, *kubectl port-forward* mechanism can be used to hit a pod.
Use the following command to start port-forwarding
```
kubectl port-forward $(kubectl get pods --all-namespaces -o name | grep -i kuard) 8080
```
and hit the service from another shell:
 ```curl localhost:8080```