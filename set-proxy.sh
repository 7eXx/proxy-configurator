#!/bin/sh

PROXY_URL=http://10.0.2.1:3128

export http_proxy='$PROXY_URL'
export https_proxy='$PROXY_URL'

export HTTP_PROXY='$PROXY_URL'
export HTTPS_PROXY='$PROXY_URL'

sudo snap set system proxy.http="$PROXY_URL"
sudo snap set system proxy.https="$PROXY_URL"

git config --global http.proxy $PROXY_URL
git config --global https.proxy $PROXY_URL

npm config set proxy $PROXY_URL
npm config set https-proxy $PROXY_URL
 	
echo "[Service]
Environment=\"HTTP_PROXY=$PROXY_URL\"
Environment=\"HTTPS_PROXY=$PROXY_URL\"
Environment=\"NO_PROXY=localhost,127.0.0.1\"" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf

sudo systemctl daemon-reload

sudo systemctl restart docker.service
