#!/bin/bash
HDFS_FORMAT_MARKER="/etc/hadoop/hdfs.format"
DAEMON=$1

if [ -e "$HDFS_FORMAT_MARKER" ]; then
    echo "Found the HDFS format marker. Formatting hdfs before starting";

    set HDFS_PATH_NN="$(xpath /etc/hadoop/conf/hdfs-site.xml '/configuration/property[name="dfs.namenode.name.dir"]/value/text()')"
    mkdir -p $HDFS_PATH_NN

    /usr/bin/hadoop --config /etc/hadoop/conf namenode -format -force -nonInteractive

    if [ $? -eq 0 ]; then
        rm -rf "$HDFS_FORMAT_MARKER"
    fi
fi

if [ ! -e "$HDFS_FORMAT_MARKER" ]; then
    /usr/bin/hdfs --config /etc/hadoop/conf namenode
fi
