import pika

credentials = pika.PlainCredentials("admin", "admin")
connection = pika.BlockingConnection(
    pika.ConnectionParameters(host="rabbitmq-cluster.rabbitmq", port=5672, credentials=credentials)
)
channel = connection.channel()

print("チャンネルが作成されました")

channel.close()
connection.close()
