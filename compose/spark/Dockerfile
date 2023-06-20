# FROM python:3.9-bullseye
FROM ethanjolly/pyspark_base

# COPY SparkManager.py .
# COPY TopicConsumer.py .
# COPY main.py .
COPY /src /src
# COPY requirements.txt .
COPY Trade.avsc .

# COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

# ENV JAVA_HOME="/usr/local/openjdk-8"

# RUN pip install -r requirements.txt
CMD ["python", "-u", "src/main.py"]
