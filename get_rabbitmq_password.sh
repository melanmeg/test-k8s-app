#!/bin/bash

username=$(kubectl get secret -n rabbitmq rabbitmq-cluster-default-user -o jsonpath="{.data.username}" | base64 --decode)
password=$(kubectl get secret -n rabbitmq rabbitmq-cluster-default-user -o jsonpath="{.data.password}" | base64 --decode)

echo "username: $username"
echo "password: $password"
