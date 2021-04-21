#!/bin/sh

unset HTTP_PROXY
unset HTTPS_PROXY
unset http_proxy
unset https_proxy

sudo snap unset system proxy.http
sudo snap unset system proxy.https

# remove proxy 
sudo truncate -s0 /etc/apt/apt.conf.d/10proxy.conf

# unset git proxy
git config --global --unset http.proxy
git config --global --unset https.proxy

npm config delete proxy
npm config delete https-proxy

# remove proxy for docker service
sudo truncate -s0 /etc/systemd/system/docker.service.d/http-proxy.conf

sudo systemctl daemon-reload

sudo systemctl restart docker.service
