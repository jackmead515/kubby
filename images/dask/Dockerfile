FROM ghcr.io/dask/dask:2023.3.2-py3.10

RUN pip install --upgrade --no-cache-dir \
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

ENTRYPOINT ["tini", "-g", "--", "/usr/bin/entrypoint.sh"]