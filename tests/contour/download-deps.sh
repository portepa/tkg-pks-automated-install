#!/bin/bash

set -ex
wget https://projectcontour.io/quickstart/contour.yaml

source images.sh

for image in "${image_list[@]}"; do
    echo "Downloaing ${image}";
    docker pull $image;
    docker save $image -o "$(echo $image | sed 's/^.*\///' | sed 's/:.*$//').tar"
done

