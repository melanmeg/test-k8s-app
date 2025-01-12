```bash
$ helm install my-kafka bitnami/kafka --version 31.2.0 -f values.yaml -n kafka
NAME: my-kafka
LAST DEPLOYED: Sun Jan 12 22:10:27 2025
NAMESPACE: kafka
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kafka
CHART VERSION: 31.2.0
APP VERSION: 3.9.0

Did you know there are enterprise versions of the Bitnami catalog? For enhanced secure software supply chain features, unlimited pulls from Docker, LTS support, or application customization, see Bitnami Premium or Tanzu Application Catalog. See https://www.arrow.com/globalecs/na/vendors/bitnami for more information.

** Please be patient while the chart is being deployed **

Kafka can be accessed by consumers via port 9092 on the following DNS name from within your cluster:

    my-kafka.kafka.svc.cluster.local

Each Kafka broker can be accessed by producers via port 9092 on the following DNS name(s) from within your cluster:

    my-kafka-controller-0.my-kafka-controller-headless.kafka.svc.cluster.local:9092
    my-kafka-controller-1.my-kafka-controller-headless.kafka.svc.cluster.local:9092
    my-kafka-controller-2.my-kafka-controller-headless.kafka.svc.cluster.local:9092
    my-kafka-broker-0.my-kafka-broker-headless.kafka.svc.cluster.local:9092
    my-kafka-broker-1.my-kafka-broker-headless.kafka.svc.cluster.local:9092
    my-kafka-broker-2.my-kafka-broker-headless.kafka.svc.cluster.local:9092

The CLIENT listener for Kafka client connections from within your cluster have been configured with the following security settings:
    - SASL authentication

To connect a client to your Kafka, you need to create the 'client.properties' configuration files with the content below:

security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
    username="user1" \
    password="$(kubectl get secret my-kafka-user-passwords --namespace kafka -o jsonpath='{.data.client-passwords}' | base64 -d | cut -d , -f 1)";

To create a pod that you can use as a Kafka client run the following commands:

    kubectl run my-kafka-client --restart='Never' --image docker.io/bitnami/kafka:3.9.0-debian-12-r4 --namespace kafka --command -- sleep infinity
    kubectl cp --namespace kafka client.properties my-kafka-client:/tmp/client.properties
    kubectl exec --tty -i my-kafka-client --namespace kafka -- bash

    PRODUCER:
kafka-console-producer.sh \
    --producer.config /tmp/client.properties \
    --bootstrap-server my-kafka.kafka.svc.cluster.local:9092 \
    --topic test

    CONSUMER:
        kafka-console-consumer.sh \
            --consumer.config /tmp/client.properties \
            --bootstrap-server my-kafka.kafka.svc.cluster.local:9092 \
            --topic test \
            --from-beginning

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
  - broker.resources
  - controller.resources
+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
```

```bash
kafka-topics.sh \
  --command-config /tmp/client.properties \
  --bootstrap-server my-kafka.kafka.svc.cluster.local:9092 \
  --list
```
