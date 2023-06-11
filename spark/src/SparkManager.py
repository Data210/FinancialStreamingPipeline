import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql.avro.functions import from_avro
import uuid
import time

class SparkManager:
    def __init__(self, master_url, app_name, bootstrap_servers, topic, schema_path) -> None:
        self.bootstrap_servers = bootstrap_servers
        self.topic = topic
        self.schema_path = schema_path
        self.app_name = app_name
        self.master_url = master_url
        self.session = SparkSession.builder \
            .appName(self.app_name) \
            .master(self.master_url) \
            .config("spark.driver.bindAddress","0.0.0.0") \
            .config("spark.cassandra.connection.host","cassandra") \
            .config("spark.cassandra.connection.port","9042") \
            .config("spark.cassandra.auth.username","cassandra")\
            .config("spark.cassandra.auth.password","cassandra")\
            .getOrCreate()
        self.schema = self.get_avro_schema()
        self.uuid_generator = udf(lambda : str(uuid.uuid4()),StringType())
        
    def get_avro_schema(self):
        with open(self.schema_path) as f:
            schema = f.read()
        return schema
    
    def get_current_time(self):
        print(str(int(time.time())))
        return time.time()

    def save_to_cassandra(self, batch_df, batch_id):
          batch_df.write.format("org.apache.spark.sql.cassandra")\
          .option("keyspace", "market")\
          .option("table", "trades")\
          .mode("append")\
          .save()

    def create_df(self):
        df = self.session\
            .readStream \
            .format("kafka") \
            .option("kafka.bootstrap.servers", self.bootstrap_servers) \
            .option("subscribe", self.topic) \
            .load()
        
        df_transformed = df \
                .withColumn("avroData",from_avro(col("value"), self.schema)) \
                .select("avroData.*") \
                .select(explode("data"),"type") \
                .select("col.*") \
                .withColumn("uuid",self.uuid_generator())
        
        df_cleaned = df_transformed \
                    .withColumnRenamed("c","trade_conditions") \
                    .withColumnRenamed("p","price") \
                    .withColumnRenamed("s","symbol") \
                    .withColumnRenamed("v","volume") \
                    .withColumnRenamed("t","trade_timestamp") \
                    .withColumn("trade_timestamp",(col("trade_timestamp") / 1000).cast("timestamp")) \
                    .withColumn("ingest_timestamp",to_timestamp(current_timestamp())) \
                    .select("symbol","trade_timestamp","ingest_timestamp","price","trade_conditions","uuid","volume")
        
        return df_cleaned
    
    def cassandra_write_query(self, df):        
        logging_query = df \
                .writeStream \
                .format("console") \
                .outputMode("append") \
                .start()
        
        cassandra_query = df \
                .writeStream \
                .foreachBatch(self.save_to_cassandra) \
                .outputMode("update") \
                .start()
 
        self.session.streams.awaitAnyTermination()