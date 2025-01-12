import pika

credentials = pika.PlainCredentials("admin", "admin")
connection = pika.BlockingConnection(
    pika.ConnectionParameters(host="192.168.11.161",
                              port=8091, credentials=credentials)
)
channel = connection.channel()

channel.queue_declare(queue="my_queue2")
print("チャンネルが作成されました")


def callback(ch, method, properties, body):
  print(f"受信したメッセージ: {body}")


channel.basic_consume(
    queue="my_queue2", on_message_callback=callback, auto_ack=True)

print("メッセージを待機しています...")
channel.start_consuming()

channel.close()
connection.close()
