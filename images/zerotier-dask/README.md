

docker build -t 'dask-test' .	


docker run \
	--name dask-test \
	--rm \
	--cap-add NET_ADMIN \
	--device /dev/net/tun \
	-e ZEROTIER_NETWORK_ID='d5e5fb6537892d5d' \
	-e DASK_SCHEDULER_URL='tcp://172.23.0.100:32227' \
	-e ZEROTIER_API_TOKEN='8j4CCbR2sJrCRKboVs9dCFIkXfCbVNns' \
	dask-test:latest

