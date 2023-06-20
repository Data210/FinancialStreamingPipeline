from fastavro import schemaless_writer, reader, parse_schema
from fastavro.schema import load_schema
import io
from confluent_kafka import Producer
from confluent_kafka.admin import AdminClient


class MessageRelay():
    def __init__(self,bootstrap_servers, topic, schema_path) -> None:
        self.schema_path = schema_path
        self.load_schema()
        self.bootstrap_servers = bootstrap_servers
        self.topic = topic
        while True:
            try:
                self.producer = Producer({'bootstrap.servers': self.bootstrap_servers})
                break
            except Exception as e:
                print(e)

    def dispatch(self,message):
        self.producer.produce(self.topic, value=self.encode(message))
        self.producer.flush()


    def on_send_success(self, record_metadata):
        print("Topic:",record_metadata.topic)
        print("Partition:",record_metadata.partition)
        print("Offset:",record_metadata.offset)

    def on_send_error(self, excp):
        print(f'MessageRelay error: {excp}')
        
    def encode(self,data):
        bytes_writer = io.BytesIO()
        schemaless_writer(bytes_writer, self.schema, data)
        return bytes_writer.getvalue()
    
    def load_schema(self):
        """
        Load schema from .avsc file
        """
        if self.schema_path is None:
            raise Exception("schema_path is missing")
        self.schema = parse_schema(load_schema(self.schema_path))