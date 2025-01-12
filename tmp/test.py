import pika

credentials = pika.PlainCredentials("admin", "admin")
connection = pika.BlockingConnection(
    pika.ConnectionParameters(host="192.168.11.161", port=8091, credentials=credentials)
)
channel = connection.channel()

channel.queue_declare(queue="my_queue")
print("チャンネルが作成されました")

channel.close()
connection.close()
