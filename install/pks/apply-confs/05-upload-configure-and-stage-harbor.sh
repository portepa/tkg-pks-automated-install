export OM_TARGET=10.193.179.22
export OM_PASSWORD=AHxOEg6fu3SHCDwUnm!
export OM_USERNAME=admin
export OM_SKIP_SSL_VALIDATION=true

# UPLOAD

om -k upload-product --product harbor-container-registry-1.10.1-build.7.pivotal

# STAGE

om stage-product --product-name harbor-container-registry --product-version 1.10.1-build.7

# CONFIGURE

bosh interpolate ./base-confs/harbor-conf.yml -l ./values/harbor.yml > harbor-final.yml
om -k configure-product --config harbor-final.yml