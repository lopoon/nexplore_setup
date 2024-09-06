# Windows PowerShell

# Check if Docker Desktop is installed
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker Desktop is not found. Please install Docker Desktop and enable Kubernetes through the Docker Desktop settings."
    exit
}

# create k8s secret
kubectl create secret generic nexplore-postgres-secret -n nexplore `
    --from-literal=user=nexplore `
    --from-literal=dbname=nexplore `
    --from-literal=password=B68OYrP7ylWAeyaE9IxIqA==

# create db
kubectl apply -f postgres.yaml -n nexplore
kubectl apply -f todo-api.yaml -n nexplore
kubectl apply -f todo-web.yaml -n nexplore
kubectl apply -f ingress.yaml -n nexplore

# create db table
kubectl run psql -n nexplore --rm -i --tty --image postgres:13 --env="PGPASSWORD=$(kubectl get secret nexplore-postgres-secret -n nexplore -o jsonpath='{.data.password}' | base64 --decode)" -- psql -h nexplore-db -U $(kubectl get secret nexplore-postgres-secret -n nexplore -o jsonpath='{.data.user}' | base64 --decode) -d $(kubectl get secret nexplore-postgres-secret -n nexplore -o jsonpath='{.data.dbname}' | base64 --decode) -c "CREATE TABLE IF NOT EXISTS to_do_list (id SERIAL PRIMARY KEY, title VARCHAR(255), description TEXT, status BOOLEAN, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);"