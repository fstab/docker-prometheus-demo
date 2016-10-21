FROM fstab/ubuntu
MAINTAINER Fabian Stäber, fabian@fstab.de

WORKDIR /root
RUN wget -nv https://github.com/prometheus/node_exporter/releases/download/0.12.0/node_exporter-0.12.0.linux-amd64.tar.gz
RUN wget -nv https://github.com/prometheus/prometheus/releases/download/v1.2.1/prometheus-1.2.1.linux-amd64.tar.gz
RUN wget -nv https://grafanarel.s3.amazonaws.com/builds/grafana-3.1.1-1470047149.linux-x64.tar.gz
RUN wget -nv https://github.com/prometheus/alertmanager/releases/download/v0.4.2/alertmanager-0.4.2.linux-amd64.tar.gz

WORKDIR /tmp
RUN git clone https://github.com/prometheus/jmx_exporter && \
    cd jmx_exporter && \
    mvn clean install && \
    cd .. && \
    rm -rf jmx_exporter

WORKDIR /root
RUN git clone https://github.com/fstab/prometheus-for-java-developers && \
    cd prometheus-for-java-developers && \
    git checkout 05b-dropwizard-prometheus-bridge && \
    mvn clean package && \
    git checkout doc

# node_exporter
EXPOSE 9100

# prometheus
EXPOSE 9090

# grafana
EXPOSE 3000

# alertmanager
EXPOSE 9093

# Java demo application
EXPOSE 8080

# JMX to Prometheus bridge
EXPOSE 9200
