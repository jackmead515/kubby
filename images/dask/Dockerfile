FROM ghcr.io/dask/dask:2023.1.0

RUN pip install --upgrade --no-cache-dir \
    dask-ml[complete]==2023.3.24 \
    tensorflow-cpu==2.12.0 \
    opencv-python-headless==4.7.0.72 \
    opencv-contrib-python-headless==4.7.0.72 \
    streamz==0.6.4 \
    kafka-python==2.0.2 \
    zarr==2.14.2 \
    deltalake==0.8.1 \
    scikeras==0.10.0 \
    minio==7.1.14 \
    s3fs==2023.3.0 \
    boto3

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT ["tini", "-g", "--", "/usr/bin/entrypoint.sh"]