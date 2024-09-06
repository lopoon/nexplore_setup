#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    sudo apt-get update -y
    sudo apt-get install -y docker.io
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    brew install docker
    brew install minikube
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo "Please install Docker Desktop and enable Kubernetes through the Docker Desktop settings."
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    echo "Please install Docker Desktop and enable Kubernetes through the Docker Desktop settings."
else
    echo "Unknown OS. Please install Docker and Minikube manually."
fi
# create k8s secret
# kubectl create secret generic nexplore-postgres-password --from-literal=POSTGRES_PASSWORD=B68OYrP7ylWAeyaE9IxIqA==
kubectl create secret generic nexplore-postgres-secret -n nexplore \
    --from-literal=user=nexplore \
    --from-literal=dbname=nexplore \
    --from-literal=password=B68OYrP7ylWAeyaE9IxIqA== \


# create db
kubectl apply -f postgres.yaml -n nexplore
kubectl apply -f todo-api.yaml -n nexplore
kubectl apply -f todo-web.yaml -n nexplore
kubectl apply -f ingress.yaml -n nexplore




# create db table
# kubectl run psql -n nexplore --rm -i --tty --image postgres:13 --env="PGPASSWORD=$(kubectl get secret nexplore-postgres-secret -n nexplore -o jsonpath='{.data.password}' | base64 --decode)" -- psql -h nexplore-db -U $(kubectl get secret nexplore-postgres-secret -n nexplore -o jsonpath='{.data.user}' | base64 --decode) -d $(kubectl get secret nexplore-postgres-secret -n nexplore -o jsonpath='{.data.dbname}' | base64 --decode) -c "CREATE TABLE IF NOT EXISTS to_do_list (id SERIAL PRIMARY KEY, title VARCHAR(255), description TEXT, status BOOLEAN, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);"
