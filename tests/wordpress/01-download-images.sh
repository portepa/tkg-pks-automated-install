Images=(
    alexandreroman/k8s-prometheus-micrometer-demo:latest
    docker.io/bitnami/wordpress:5.3.2-debian-10-r32
    docker.io/bitnami/mariadb:10.3.22-debian-10-r27
)

for image in ${Images[*]}
do
    docker pull $image
    docker save $image -o $(basename $image).tar
done
