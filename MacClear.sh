Mac Clean Setup

kubectl delete -f todo-api.yaml -n nexplore
kubectl delete -f todo-web.yaml -n nexplore
kubectl delete -f postgres.yaml -n nexplore
kubectl delete -f ingress.yaml -n nexplore
kubectl delete secret nexplore-postgres-secret -n nexplore