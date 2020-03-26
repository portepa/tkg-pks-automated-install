# export OM_USERNAME=admin
# export OM_PASSWORD=cuvTpWKBb7396mEOjs!
# export OM_TARGET=opsmgr-02.haas-464.pez.pivotal.io

export OM_TARGET=10.193.179.22
export OM_PASSWORD=AHxOEg6fu3SHCDwUnm!
export OM_USERNAME=admin

# 1. Interpolate config
bosh interpolate ../test-bosh-interpolation/base.yml -l ../test-bosh-interpolation/secrets-haas-221.yml > bosh-final.yml

#1. apply config
om -k configure-director --config bosh-final.yml