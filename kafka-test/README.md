```bash
kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:3.9.0-debian-12-r4 --namespace kafka --command -- sleep infinity
kubectl cp --namespace kafka client.properties kafka-client:/tmp/client.properties
kubectl exec --tty -i kafka-client --namespace kafka -- bash

kafka-console-producer.sh \
    --producer.config /tmp/client.properties \
    --topic test

kafka-console-consumer.sh \
    --consumer.config /tmp/client.properties \
    --topic test \
    --from-beginning

kafka-topics.sh \
  --command-config /tmp/client.properties \
  --list
```
