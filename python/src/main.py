from TickerClient import TickerClient
from MessageRelay import MessageRelay
import rel

def main():
    # producer = Producer({'bootstrap.servers': 'kafka:29092'})
    # metadata = producer.list_topics(timeout=10)
    # print(metadata)
    ticker_client = TickerClient('AMZN')
    print('hello')
    message_relay = MessageRelay(bootstrap_servers='kafka:29092',topic='trades',schema_path='../Trade.avsc')
    ticker_client.set_receiver(message_relay.dispatch)

    rel.signal(2, rel.abort)
    rel.dispatch()

if __name__ == "__main__":
    main()
