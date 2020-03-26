export OM_TARGET=10.193.179.22
export OM_PASSWORD=AHxOEg6fu3SHCDwUnm!
export OM_USERNAME=admin

uaac target https://api.pks.haas-221.pez.pivotal.io:8443 --skip-ssl-validation
echo $(om -k credentials -p pivotal-container-service -c ".properties.pks_uaa_management_admin_client" -t json)
echo "Run 'uaac token client get admin -s REPLACE_WITH_VALUE_ABOVE'"
# 