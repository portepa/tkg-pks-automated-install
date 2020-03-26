export OM_TARGET=10.193.179.22
export OM_PASSWORD=AHxOEg6fu3SHCDwUnm!
export OM_USERNAME=admin
export OM_SKIP_SSL_VALIDATION=true

# UPLOAD

om -k upload-product --product pivotal-container-service-1.6.1-build.6.pivotal

# STAGE

om stage-product --product-name pivotal-container-service --product-version 1.6.1-build.6

# CONFIGURE

bosh interpolate ./base-confs/pks-conf.yml -l ./values/pks.yml > pks-final.yml
om -k configure-product --config pks-final.yml

# UPLOAD STEMCELL

om upload-stemcell --stemcell bosh-stemcell-456.51-vsphere-esxi-ubuntu-xenial-go_agent.tgz