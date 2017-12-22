FROM ubuntu:16.04

ENV HADOOP_HOME /opt/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN \
    apt-get update && apt-get install -y --reinstall build-essential && \
    apt-get install -y \
    ssh \
    rsync \
    vim \
    net-tools \
    openjdk-8-jdk \
    python2.7-dev \
    libxml2-dev \
    libkrb5-dev \
    libffi-dev \
    libssl-dev \
    libldap2-dev \
    python-lxml \
    libxslt1-dev \
    libgmp3-dev \
    libsasl2-dev \
    libsqlite3-dev \ 
    libmysqlclient-dev

RUN \
    if [ ! -e /usr/bin/python ]; then ln -s /usr/bin/python2.7 /usr/bin/python; fi

# If you have already downloaded the tgz, add this line OR comment it AND ...
ADD hadoop-3.0.0.tar.gz /

# ... uncomment the 2 first lines
RUN \
#    wget http://apache.crihan.fr/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz && \
#    tar -xzf hadoop-3.0.0.tar.gz && \
    mv hadoop-3.0.0 $HADOOP_HOME && \
    for user in hadoop hdfs yarn mapred hue; do \
         useradd -U -M -d /opt/hadoop/ --shell /bin/bash ${user}; \
    done && \
    for user in root hdfs yarn mapred hue; do \
         usermod -G hadoop ${user}; \
    done && \
    echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_DATANODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
#    echo "export HDFS_DATANODE_SECURE_USER=hdfs" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_NAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_SECONDARYNAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export YARN_RESOURCEMANAGER_USER=root" >> $HADOOP_HOME/etc/hadoop/yarn-env.sh && \
    echo "export YARN_NODEMANAGER_USER=root" >> $HADOOP_HOME/etc/hadoop/yarn-env.sh && \
    echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

####################################################################################
# HUE

ADD hue-4.1.0.tgz /

RUN \
#    wget https://www.dropbox.com/s/auwpqygqgdvu1wj/hue-4.1.0.tgz && \
#    tar -xzf hue-4.1.0.tgz && \
    cd hue-4.1.0 && \
    PREFIX=/opt make install && \
    chown -R hue:hue /opt/hue


####################################################################################

RUN \
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

ADD *xml $HADOOP_HOME/etc/hadoop/

ADD ssh_config /root/.ssh/config

ADD hue.ini /opt/hue/desktop/conf

ADD start-all.sh start-all.sh

EXPOSE 8088 9870 9864 19888 8042 8888

CMD bash start-all.sh
