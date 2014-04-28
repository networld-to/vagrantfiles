#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

sudo echo 'deb http://nginx.org/packages/debian/ wheezy nginx' > /etc/apt/sources.list.d/nginx.list
sudo echo 'deb-src http://nginx.org/packages/debian/ wheezy nginx' >> /etc/apt/sources.list.d/nginx.list

(cd /tmp && \
  wget http://nginx.org/keys/nginx_signing.key && \
  sudo apt-key add /tmp/nginx_signing.key) &> /dev/null
rm -f /tmp/nginx_signing.key

sudo aptitude update && sudo aptitude install -y nginx
