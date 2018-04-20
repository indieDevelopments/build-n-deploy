#!/bin/bash
# https://certbot.eff.org/#ubuntutrusty-nginx

apt-get install -y software-properties-common
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install -y certbot

echo "Woop! Let's Encrypt is installed. You can simply create new cert by run: `sudo certbot certonly --standalone DOMAIN_NAME(S)`'"
