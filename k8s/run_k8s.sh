kubectl apply -f cassandra.yaml
kubectl apply -f zookeeper.yaml
kubectl apply -f kafka.yaml
kubectl apply -f websocket.yaml
kubectl apply -f spark_master.yaml
kubectl apply -f grafana.yaml
kubectl get pods -o wide