from SparkManager import SparkManager
import time
import os

SUBMIT_ARGS = "--packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.1,org.apache.spark:spark-avro_2.12:3.3.0,com.datastax.spark:spark-cassandra-connector_2.12:3.0.0 pyspark-shell"
os.environ["PYSPARK_SUBMIT_ARGS"] = SUBMIT_ARGS

def main():
    time.sleep(15)
    print('hola')
    sm = SparkManager("spark://spark-master:7077",'test_app',bootstrap_servers='kafka:29092',topic='trades',schema_path='Trade.avsc')
    df = sm.create_df()
    sm.cassandra_write_query(df)
    
if __name__ == '__main__':
    main()
