# KUBBY

This is just my personal Kubernetes manifest repository.

I have a lot of stuff in here that I want to put. Lots of distributed computation frameworks, storage systems, some other junk.

Anyone can use it. I've written a guide on how to deploy it. It's Kubernetes! It's pretty straight forward.

I have this setup on a home cluster. And old laptop. Some raspberry pis, maybe some other computers (I'd like to run it on an old cell phone lol). As I get more computers, I'll add more to the cluster. I think it's kinda like a spaghetti machine.

## What's Inside?

- [Kafka](https://kafka.apache.org/)
- [Zookeeper](https://zookeeper.apache.org/)
- [Dask](https://dask.org/)
- [Argo](https://argoproj.github.io/)
- [Minio](https://min.io/)
- [InfluxDB](https://www.influxdata.com/)

This is kinda my dream suite. I have a messaging bus (Kafka) that is really scaliable. I deploy Dask because it's more fun than Spark and it's not Spark. Argo is here because it's such a cool tool for automation when you know how to use it. Minio is a must because it's my distributed storage system. InfluxDB is here because it's such a kick ass time series database.