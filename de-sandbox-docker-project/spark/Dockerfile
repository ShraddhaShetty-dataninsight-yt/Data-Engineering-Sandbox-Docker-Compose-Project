# spark/Dockerfile
FROM openjdk:17-jdk-slim

# --- install system deps ---
USER root
RUN apt-get update && apt-get install -y curl ca-certificates wget git python3 python3-pip scala bash netcat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Spark version and Hadoop
ENV SPARK_VERSION=3.5.1
ENV HADOOP_VERSION=3

# Download and install Spark binary (prebuilt for Hadoop)
RUN curl -SL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    | tar -xz -C /opt && \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Install Python libs commonly used in DE workflows (preinstalled)
RUN pip3 install --no-cache-dir \
    pyspark==3.5.1 \
    pandas \
    kafka-python \
    sqlalchemy \
    mariadb \
    psycopg2-binary \
    redis \
    pyarrow \
    fastavro

# Create dirs for events & jars & SQL scripts
RUN mkdir -p /opt/spark/jars /spark-events /opt/sql-scripts
VOLUME ["/opt/spark/jars", "/spark-events", "/opt/sql-scripts"]

# Add helper entrypoint script to start master/worker/history based on env
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER 1000
WORKDIR /home

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["bash"]
