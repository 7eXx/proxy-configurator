#!/bin/sh

PROXY_URL=http://10.0.2.1:3128
NO_PROXY_URL=localhost,127.0.0.1,10.0.*

echo "proxy url is: $PROXY_URL"
echo "no proxy url: $NO_PROXY_URL"

# set proxy for profile shell
echo "
http_proxy=\"$PROXY_URL\"
export http_proxy
https_proxy=\"$PROXY_URL\"
export https_proxy
no_proxy=\"$NO_PROXY_URL\"
export no_proxy

HTTP_PROXY=\"$PROXY_URL\"
export HTTP_PROXY
HTTPS_PROXY=\"$PROXY_URL\"
export HTTPS_PROXY
NO_PROXY=\"$NO_PROXY_URL\"
export NO_PROXY
" | sudo tee /etc/profile.d/proxy.sh

# snap proxy
sudo snap set system proxy.http="$PROXY_URL"
sudo snap set system proxy.https="$PROXY_URL"

# set proxy for apt
echo "
Acquire::http::Proxy \"$PROXY_URL\";
Acquire::https::Proxy \"$PROXY_URL\";
Acquire::ftp::Proxy \"$PROXY_URL\";" | sudo tee /etc/apt/apt.conf.d/10proxy.conf

git config --global http.proxy $PROXY_URL
git config --global https.proxy $PROXY_URL

npm config set proxy $PROXY_URL
npm config set https-proxy $PROXY_URL
 	
echo "
[Service]
Environment=\"HTTP_PROXY=$PROXY_URL\"
Environment=\"HTTPS_PROXY=$PROXY_URL\"
Environment=\"NO_PROXY=$NO_PROXY_URL\"" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf

sudo systemctl daemon-reload

sudo systemctl restart docker.service
