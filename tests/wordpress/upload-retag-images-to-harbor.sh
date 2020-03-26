HARBOR_URL=harbor.run.haas-464.pez.pivotal.io
HARBOR_PASSWORD=cuvTpWKBb7396mEOjs!
HARBOR_USERNAME=admin
LOCAL_IMAGES=wordpress-images

echo "ADD $HARBOR_URL to your insecure registries in ~/.docker/daemon.json if not done"
echo "Restart Docker engine \n\n"

docker login -u $HARBOR_USERNAME $HARBOR_URL -p $HARBOR_PASSWORD # change this URL
cd $LOCAL_IMAGES
for image in  `ls .`
do
  docker load --input $image | awk '{print $3}' > name
  NAME=$(cat name)
  RENAME=$(cat name|awk -F\/ '{print $(NF)}')
  docker tag $NAME $HARBOR_URL/library/$RENAME
  docker push $HARBOR_URL/library/$RENAME
done
rm -f name
