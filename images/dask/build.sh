# build docker image
docker build -t dask-worker .

docker tag dask-worker:latest jackmead515/dask-worker:v2

docker push jackmead515/dask-worker:v2