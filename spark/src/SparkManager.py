import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql.avro.functions import from_avro

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
            .getOrCreate()
        self.schema = self.get_avro_schema()

        self.schema_test = '''{
                            "type" : "record",
                            "name" : "message",
                            "namespace" : "TradeMessages",
                            "fields" : [ {
                              "name" : "data",
                              "type" : {
                                "type" : "array",
                                "items" : {
                                  "type" : "record",
                                  "name" : "data",
                                  "fields" : [ {
                                    "name" : "c",
                                    "type":[
                                      {
                                        "type":"array",
                                        "items":["null","string"],
                                        "default":[]
                                      },
                                      "null"
                                    ],
                                    "doc" : "Message Type"
                                  }, 
                                  {
                                    "name" : "p",
                                    "type" : "double",
                                    "doc" : "Trade pricee"
                                  }, 
                                  {
                                    "name" : "s",
                                    "type" : "string",
                                    "doc" : "Ticker symbol"
                                  }, 
                                  {
                                    "name" : "t",
                                    "type" : "long",
                                    "doc" : "Trade timestamp"
                                  }, 
                                  {
                                    "name" : "v",
                                    "type" : "double",
                                    "doc" : "Volume of trade"
                                  } ]
                                },
                                "doc" : "Trades messages"
                              },
                              "doc"  : "Contains trade details"
                            }, 
                            {
                              "name" : "type",
                              "type" : "string",
                              "doc"  : "Type of message"
                            } ],
                            "doc" : "Finnhub messages schema"
                          }'''
        
    def get_avro_schema(self):
        with open(self.schema_path) as f:
            schema = f.read()
        return schema

    def test_data(self):
        data = [('James','','Smith','1991-04-01','M',3000),
          ('Michael','Rose','','2000-05-19','M',4000),
          ('Robert','','Williams','1978-09-05','M',4000),
          ('Maria','Anne','Jones','1967-12-01','F',4000),
          ('Jen','Mary','Brown','1980-02-17','F',-1)
        ]

        columns = ["firstname","middlename","lastname","dob","gender","salary"]
        df = self.session.createDataFrame(data=data, schema=columns)
        df.show()

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
                .select(explode("data"),"type")
        
        query = df_transformed \
                .writeStream \
                .format("console") \
                .outputMode("append") \
                .start()

        query.awaitTermination()