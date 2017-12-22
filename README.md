# Docker file for Hadoop 3

Most of the work is coming from : http://bigdatums.net/2017/11/04/creating-hadoop-docker-image/

Just added a few adaptations for Hadoop 3.

For some details about Hadoop 3 (such as new ports), see: https://fr.slideshare.net/HadoopSummit/hadoop-3-in-a-nutshell

> Please, read the content of Dockerfile, because it may be possible that you have to update it.
> See the comments about the tgz of hadoop3.

> After starting the container, you can access the web UI:
> * HDFS: http://localhost:9870
> * RM: http://localhost:8088
> * HUE: http://localhost:8888 (create a user `hue`)

> Warning: hue is not fully functional... Its integration is a work in progess (file browsing is ok) !


## How-to

* Build the image
```sh
sudo docker build -t hadoop3 .
```


* Run the container
```sh
sudo docker run --hostname=hadoop3 -p 8088:8088 -p 9870:9870 -p 9864:9864 -p 19888:19888 \
  -p 8042:8042 -p 8888:8888 --name hadoop3 -d hadoop3
```

* Access the container
```sh
sudo docker exec -it hadoop3 bash
```

* Test a job
```sh
yarn jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.0.0.jar pi 10 100
```

* Clean
```sh
sudo docker stop hadoop3 
sudo docker rm hadoop3 
```

## Next steps

| Product/Framework/Env. | Version | (R)equired/((O)ptional |
| --- | --- | --- |
| Hue | 4.1 | R |
| Hive | 2.3.2 | R |
| Minifi | ? | O |
| Druid | ? | O |
| Kafka | ? | O |
| Storm | ? | O |
| Spark | 2.2.0 | O |
| Ambari | 2.6.1 | O |
| Ambari-metrics | 2.6.1 | O |
| HBase | ? | O |


## Some notes

* Hue: https://www.dropbox.com/s/auwpqygqgdvu1wj/hue-4.1.0.tgz
* Hive: http://apache.crihan.fr/dist/hive/hive-2.3.2/apache-hive-2.3.2-bin.tar.gz
