# KUBBY

This is just my personal Kubernetes manifest repository.

I have a lot of stuff in here that I want to put. Lots of distributed computation frameworks, storage systems, some other junk.

Anyone can use it. I've written a guide on how to deploy it. It's Kubernetes! It's pretty straight forward.

I have this setup on my distributed network using [Zerotier](https://www.zerotier.com/). I have some computers at home and at the office. Raspberry Pi's, old laptops, a desktop computer. Honestly it's really just a spagetti monster of whatever machine I can install K3S on. It's pretty sweet because I can install a Zerotier client on my cell phone and then I have access to my Kubernetes services wherever in the world I happen to be!


## What's Inside?

- [Kafka](https://kafka.apache.org/)
- [Dask](https://dask.org/)
- [Argo](https://argoproj.github.io/)
- [Minio](https://min.io/)
- [Prometheus](https://prometheus.io/docs/introduction/overview/)

This is kinda my dream suite.
I have a messaging bus (Kafka) that is really scaliable.
I deploy Dask because it's more fun than Spark and it's not Spark.
Argo is here because it's such a cool tool for automation when you know how to use it.
Minio is a must because it's my distributed storage system.
InfluxDB is here because it's such a kick ass time series database.

## Install Zerotier

Install zerotier normally through their process. But disable routing via flannel (I default to use flannel with K3S).

```
nano /var/lib/zerotier-one/local.conf

{
  "settings": {
    "interfacePrefixBlacklist": [ "flannel" ]
  }
}
```

## Install K3S

### Install Control Plane
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=172.23.0.100 --flannel-iface=ztwdjhesdk --disable=traefik --disable=servicelb" INSTALL_K3S_VERSION="v1.25.7+k3s1" sh -

### Install Worker Node
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=172.23.0.102 --flannel-iface=ztwdjhesdk" K3S_URL="https://172.23.0.100:6443" INSTALL_K3S_VERSION="v1.25.7+k3s1" K3S_TOKEN="K10f0854fd03b7effd479a985188d862cb475696c3742af9718179f2f41fa0d1b5e::server:8afb4379f2f387cf5db6765bdc2df6c2" sh -