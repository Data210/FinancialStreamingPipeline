from SparkManager import SparkManager
from TopicConsumer import TopicConsumer
import time
import os

SUBMIT_ARGS = "--packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.1,org.apache.spark:spark-avro_2.12:3.3.0 pyspark-shell"
os.environ["PYSPARK_SUBMIT_ARGS"] = SUBMIT_ARGS

def main():
    time.sleep(15)
    sm = SparkManager("spark://spark-master:7077",'test_app',bootstrap_servers='kafka:29092',topic='trades',schema_path='Trade.avsc')
    sm.create_df()

    # consumer = TopicConsumer(bootstrap_servers='kafka:29092',topic='trades',schema_path='Trade.avsc',group_id='pysparkingest')
    # consumer.start()

if __name__ == '__main__':
    main()
