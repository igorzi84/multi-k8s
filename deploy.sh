docker build -t igorz/multi-client:latest -t igorz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t igorz/multi-server:latest -t igorz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t igorz/multi-worker:latest -t igorz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push igorz/multi-client:latest
docker push igorz/multi-server:latest
docker push igorz/multi-worker:latest

docker push igorz/multi-client:$SHA
docker push igorz/multi-server:$SHA
docker push igorz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=igorz/multi-server:$SHA
kubectl set image deployments/client-deployment client=igorz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=igorz/multi-worker:$SHA