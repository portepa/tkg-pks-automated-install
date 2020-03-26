echo " --- GRAFANA --- "

echo "USER: $(kubectl get secrets release-name-grafana -o=jsonpath='{.data.admin-user}' | base64 -D)"
echo "PASSWORD: $(kubectl get secrets release-name-grafana -o=jsonpath='{.data.admin-password}' | base64 -D)"

echo " --- TO EXPOSE GRAFANA ---"

echo "kubectl port-forward svc/release-name-grafana 8080:80"

echo "http://localhost:8080"