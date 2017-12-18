# Docker file for Hadoop 3

Most of the work is coming from : http://bigdatums.net/2017/11/04/creating-hadoop-docker-image/

Just added a few adaptations for Hadoop 3.

For some details about Hadoop 3 (such as new ports), see: https://fr.slideshare.net/HadoopSummit/hadoop-3-in-a-nutshell


* Build the image
```sh
sudo docker build -t hadoop3 .
```


* Run the container
```sh
sudo docker run --hostname=hadoop3 -p 8088:8088 -p 9870:9870 -p 9864:9864 -p 19888:19888 -p 8042:8042 --name hadoop3 -d hadoop3
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
