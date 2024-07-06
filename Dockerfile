# Elasticsearch Dockerfile
# Base image
FROM openjdk:8-jre

# Environment variables
ENV ES_VERSION=1.5.0
ENV ES_PKG_NAME elasticsearch-$ES_VERSION

# Install necessary tools
RUN apt-get update && apt-get install -y wget tar

# Install Elasticsearch
RUN \
  wget -qO - https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME.tar.gz | tar xz && \
  mv $ES_PKG_NAME /elasticsearch

# Define mountable directories
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory
WORKDIR /elasticsearch

# Expose ports
EXPOSE 9200 9300

# Start Elasticsearch
CMD ["./bin/elasticsearch"]

