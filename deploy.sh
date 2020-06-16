docker build -t christianroth/multi-client:latest -t christianroth/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t christianroth/multi-server:latest -t christianroth/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t christianroth/multi-worker:latest -t christianroth/multi-worker:$SHA-f ./worker/Dockerfile ./worker

docker push christianroth/multi-client:latest
docker push christianroth/multi-server:latest
docker push christianroth/multi-worker:latest

docker push christianroth/multi-client:$SHA
docker push christianroth/multi-server:$SHA
docker push christianroth/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=christianroth/multi-server:$SHA
kubectl set image deployments/client-deployment server=christianroth/multi-client:$SHA
kubectl set image deployments/worker-deployment server=christianroth/multi-worker:$SHA
#kubectl rollout restart -f server-deployment.yaml
#kubectl rollout restart -f client-deployment.yaml
#kubectl rollout restart -f worker-deployment.yaml
