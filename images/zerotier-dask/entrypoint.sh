#!/bin/sh

set -x

grepzt() {
  [ -f /var/lib/zerotier-one/zerotier-one.pid -a -n "$(cat /var/lib/zerotier-one/zerotier-one.pid 2>/dev/null)" -a -d "/proc/$(cat /var/lib/zerotier-one/zerotier-one.pid 2>/dev/null)" ]
  return $?
}

mkztfile() {
  file=$1
  mode=$2
  content=$3

  mkdir -p /var/lib/zerotier-one
  echo "$content" > "/var/lib/zerotier-one/$file"
  chmod "$mode" "/var/lib/zerotier-one/$file"
}

if [ "x$ZEROTIER_API_SECRET" != "x" ]
then
  mkztfile authtoken.secret 0600 "$ZEROTIER_API_SECRET"
fi

if [ "x$ZEROTIER_IDENTITY_PUBLIC" != "x" ]
then
  mkztfile identity.public 0644 "$ZEROTIER_IDENTITY_PUBLIC"
fi

if [ "x$ZEROTIER_IDENTITY_SECRET" != "x" ]
then
  mkztfile identity.secret 0600 "$ZEROTIER_IDENTITY_SECRET"
fi

mkztfile zerotier-one.port 0600 "9993"

killzerotier() {
  kill $(cat /var/lib/zerotier-one/zerotier-one.pid 2>/dev/null)
  exit 0
}

trap killzerotier INT TERM

mkdir -p /var/lib/zerotier-one/networks.d

nohup /usr/sbin/zerotier-one &

while ! grepzt
do
  if [ -f nohup.out ]
  then
    tail -n 10 nohup.out
  fi
  sleep 1
done

/usr/sbin/zerotier-cli join $ZEROTIER_NETWORK_ID

ZEROTIER_MEMBER_ID=$(zerotier-cli info | cut -d " " -f 3)

curl -X POST 'http://localhost:9993/controller/network/${ZEROTIER_NETWORK_ID}/member/${ZEROTIER_MEMBER_ID}' \
-H "X-ZT1-AUTH: ${ZEROTIER_API_TOKEN}" \
-d '{"authorized": true}'

/usr/sbin/zerotier-cli status
/usr/sbin/zerotier-cli peers

if [ "$EXTRA_PIP_PACKAGES" ]; then
    echo "EXTRA_PIP_PACKAGES environment variable found.  Installing".
    /opt/conda/bin/pip install $EXTRA_PIP_PACKAGES
fi

dask-worker \
    $DASK_SCHEDULER_URL \
    --no-dashboard

exec "$@"
