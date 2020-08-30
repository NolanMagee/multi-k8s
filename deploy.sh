docker build -t nolanmagee/multi-client:latest -t nolanmagee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nolanmagee/multi-server:latest -t nolanmagee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nolanmagee/multi-worker:latest -t nolanmagee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nolanmagee/multi-client:latest
docker push nolanmagee/multi-server:latest
docker push nolanmagee/multi-worker:latest

docker push nolanmagee/multi-client:$SHA
docker push nolanmagee/multi-server:$SHA
docker push nolanmagee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nolanmagee/multi-server:$SHA
kubectl set image deployments/client-deployment client=nolanmagee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nolanmagee/multi-worker:$SHA
