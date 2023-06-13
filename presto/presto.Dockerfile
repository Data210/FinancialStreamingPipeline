FROM openjdk:8-jre

# Presto version will be passed in at build time
ARG PRESTO_VERSION=0.281

# Set the URL to download
ARG PRESTO_BIN=https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz

# Update the base image OS and install wget and python
RUN apt-get update
RUN apt-get install -y wget python less

# Download Presto and unpack it to /opt/presto
RUN wget --quiet ${PRESTO_BIN}
RUN mkdir -p /opt
RUN tar -xf presto-server-${PRESTO_VERSION}.tar.gz -C /opt
RUN rm presto-server-${PRESTO_VERSION}.tar.gz
RUN ln -s /opt/presto-server-${PRESTO_VERSION} /opt/presto

RUN tar xvf prestoadmin-1.2-online.tar.bz2
RUN cd prestoadmin
RUN ./install-prestoadmin.sh

# Copy configuration files on the host into the image
COPY etc/cassandra.properties /opt/presto/etc/catalog/cassandra.properties
COPY etc/config.properties /opt/presto/etc/config.properties
COPY etc/node.properties /opt/presto/etc/node.properties
COPY etc/jvm.config /opt/presto/etc/jvm.config

# Download the Presto CLI and put it in the image
RUN wget --quiet https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar
RUN mv presto-cli-${PRESTO_VERSION}-executable.jar /usr/local/bin/presto
RUN chmod +x /usr/local/bin/presto

# Specify the entrypoint to start
ENTRYPOINT /opt/presto/bin/launcher run