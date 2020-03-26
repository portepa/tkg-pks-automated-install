SVC_IP=10.100.200.246
KUBE_WORKER_IP=172.28.0.4
NODEPORT_PORT=31095

kubectl exec -ti pod/wordpress-release-wordpress-6954b58f5f-zqcmc curl $SVC_IP:80
kubectl exec -ti pod/wordpress-release-wordpress-6954b58f5f-zqcmc curl $KUBE_WORKER_IP:$NODEPORT_PORT

kubectl port-forward svc/wordpress-release-wordpress 9090:80

kubectl get -o=jsonpath='{.status.hostIP}' pod/wordpress-release-mariadb-0
kubectl delete pod/wordpress-release-mariadb-0