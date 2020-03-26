HARBOR_URL=10.193.179.29
HARBOR_PASSWORD=AHxOEg6fu3SHCDwUnm!
HARBOR_USERNAME=admin

echo "ADD $HARBOR_URL to your insecure registries in ~/.docker/daemon.json if not done"
echo "Restart Docker engine \n\n"

docker login -u $HARBOR_USERNAME $HARBOR_URL -p $HARBOR_PASSWORD # change this URL

Images=(
    alexandreroman/k8s-prometheus-micrometer-demo:latest
    prom/node-exporter:v0.18.1
    quay.io/coreos/kube-state-metrics:v1.9.5
    prom/alertmanager:v0.20.0
    jimmidyson/configmap-reload:v0.3.0
    prom/pushgateway:v1.0.1
    prom/prometheus:v2.16.0
    bats/bats:v1.1.0
    grafana/grafana:6.6.2
    docker.io/dduportal/bats:0.4.0
    docker.io/bitnami/wordpress:5.3.2-debian-10-r32
    docker.io/bitnami/mariadb:10.3.22-debian-10-r27
)

for image in ${Images[*]}
do
    docker load $(basename $image).tar
    docker tag $image $HARBOR_URL/library/$(basename $image)
    docker push $HARBOR_URL/library/$(basename $image)
done
