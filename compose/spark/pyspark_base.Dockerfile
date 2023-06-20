FROM python:3.9-bullseye

COPY requirements.txt .

COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

ENV JAVA_HOME="/usr/local/openjdk-8"

RUN pip install -r requirements.txt