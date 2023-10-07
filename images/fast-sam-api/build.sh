# build docker image
docker build -t fast-sam .

docker tag fast-sam:latest jackmead515/fast-sam-api:$1

docker push jackmead515/fast-sam-api:$1