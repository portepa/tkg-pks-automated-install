pks login -a api.pks.haas-221.pez.pivotal.io -k -u idemia-user -p Idemia2020

pks create-cluster -p small -e cluster02.run.haas-221.pez.pivotal.io cluster02

pks login -a api.pks.haas-221.pez.pivotal.io -k -u idemia-admin -p Idemia2020

pks create-cluster -p small -e cluster03.run.haas-221.pez.pivotal.io cluster03
