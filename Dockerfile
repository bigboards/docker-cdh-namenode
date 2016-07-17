# Pull base image.
FROM bigboards/cdh-base-__arch__

MAINTAINER bigboards
USER root 

RUN apt-get update \
    && apt-get install -y hadoop-hdfs-namenode \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

ADD docker_files/namenode-run.sh /apps/namenode-run.sh
ADD docker_files/hdfs.format /etc/hadoop/hdfs.format
RUN chmod a+x /apps/namenode-run.sh

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

# external ports
EXPOSE 50070 50470 

CMD ["/apps/namenode-run.sh"]
