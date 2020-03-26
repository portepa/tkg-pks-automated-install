PKS_API=api.pks.haas-464.pez.pivotal.io
PKS_USERNAME=admin
PKS_PASSWORD=CPfwGQbJu_1FY2-JpJ6sDTUga3KHRUVD

echo "pks login -u $PKS_USERNAME -p $PKS_PASSWORD -a $PKS_API -k"
pks login -u $PKS_USERNAME -p $PKS_PASSWORD -a $PKS_API -k

echo "listing clusters"

pks clusters