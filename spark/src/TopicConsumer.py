import io
from fastavro import schemaless_reader, parse_schema
from fastavro.schema import load_schema
from confluent_kafka import Consumer

class TopicConsumer():
    def __init__(self,bootstrap_servers,topic,schema_path,group_id) -> None:
        self.bootstrap_servers = bootstrap_servers
        self.topic = topic
        self.schema_path = schema_path
        self.load_schema()

        consumer_conf = {'bootstrap.servers': bootstrap_servers,
                        'group.id': group_id,
                        'auto.offset.reset': "earliest"}
        
        self.consumer = Consumer(consumer_conf)
        self.consumer.subscribe([topic])
    
    def start(self):
        while True:
            try:
                msg = self.consumer.poll(1.0)
                if msg is None:
                    continue
                print(msg.value())
                data = self.decode(msg.value())
            except KeyboardInterrupt:
                break

    def decode(self,data):
        bytes_reader = io.BytesIO(data)
        # print(json.loads(data))
        print(schemaless_reader(bytes_reader, self.schema))

    def load_schema(self):
        """
        Load schema from .avsc file
        """
        if self.schema_path is None:
            raise Exception("schema_path is missing")
        self.schema = parse_schema(load_schema(self.schema_path))

if __name__ == "__main__":
    consumer = TopicConsumer(bootstrap_servers='kafka:29092',topic='trades',schema_path='Trade.avsc',group_id='pysparkingest')
    consumer.start()