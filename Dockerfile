# Pull base image.
#FROM bigboards/cdh-base-__arch__
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update && apt-get install -y hadoop-hdfs-namenode 

ADD docker_files/namenode-run.sh /apps/namenode-run.sh
ADD docker_files/hdfs.format /etc/hadoop/hdfs.format
RUN chmod a+x /apps/namenode-run.sh

# external ports
EXPOSE 50070 50470 

CMD ["/apps/namenode-run.sh"]
