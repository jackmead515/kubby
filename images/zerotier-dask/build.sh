# build docker image
docker build -t zerotier-dask-worker-cpu .

docker tag zerotier-dask-worker-cpu:latest jackmead515/zerotier-dask-worker-cpu:$1

docker push jackmead515/zerotier-dask-worker-cpu:$1
