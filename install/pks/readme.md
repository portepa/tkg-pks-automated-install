# How to install PKS

## Prereq

Download Tanzu Tiles (via `om` or `pivnet` or directly through web):
- PKS: pivotal-container-service-1.6.1-build.6.pivotal
- Harbor: harbor-container-registry-1.10.1-build.7.pivotal

Download stemcells:
- bosh-stemcell-456.51-vsphere-esxi-ubuntu-xenial-go_agent.tgz

## Step 1

1. Install ESXi
2. Install vCenter
3. Create 3 Resource Pools named `pks-az1`, `pks-az2`, `pks-az3`

## Step 2

Upload and start OpsManager OVA from network.pivotal.io

## Step 3

That's where the automation and use of this repo starts.

1. Make sure the VM is started and reachable
2. Change OM Credentials with the ones you'll set (whatever you want) in all of the `0x-files.sh` (yes I know, PR welcome for avoiding copy/paste :-))
3. Change values in `./values/*` with the ones of your env
4. Change values in `./test-bosh-interpolation/secrets-haas-221.yml` with the ones of your env (BOSH variables and base conf is in this directory and not in `base-confs` and `values`)
5. Change values in PKS yaml files from line 81 to 92 (was forgotten during interpolation) to point to your vCenter (file: `./base-confs/pks-conf.yml`)
6. Launch commands one after the other (`00-x.sh` to `05-x.sh`)
7. Go to harbor tile within OpsMan GUI and generate a certificate as described so you'll be able to pull/push images.
8. Apply changes through GUI or run `06-apply-harbor.sh`
