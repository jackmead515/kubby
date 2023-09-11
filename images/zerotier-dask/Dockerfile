#FROM zerotier/zerotier:1.12.1
FROM ubuntu:22.04

RUN apt update \
	&& apt upgrade \
	&& apt install software-properties-common curl -y \
	&& add-apt-repository ppa:deadsnakes/ppa

RUN curl https://install.zerotier.com/ | bash || :

RUN /usr/sbin/zerotier-one --version -d

RUN apt install python3.10 python3-pip -y

RUN python3 -m pip install --upgrade pip

RUN python3 --version && pip3 --version && zerotier-cli --version

RUN pip install --upgrade --no-cache-dir \
    dask[complete]==2023.3.2 \
    dask-ml[complete]==2023.3.24 \
    tensorflow-cpu==2.12.0 \
    opencv-python-headless==4.8.0.76 \
    opencv-contrib-python-headless==4.8.0.76 \
    streamz==0.6.4 \
    kafka-python==2.0.2 \
    zarr==2.14.2 \
    scikeras==0.10.0 \
    s3fs==2023.6.0 \
    boto3

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
