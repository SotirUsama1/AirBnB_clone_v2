#!/usr/bin/env bash
# Sets up your web servers for the deployment of web_static.

apt-get -y update
apt-get -y upgrade
apt-get -y install nginx
ufw allow 'Nginx HTTP'

mkdir -p /data/
mkdir -p /data/web_static/
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
touch /data/web_static/releases/test/index.html
echo "<html>
  <head>
  </head>
  <body>
	Holberton School
  </body>
</html>" | tee /data/web_static/releases/test/index.html

ln -s -f /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu:ubuntu /data/

sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

service nginx restart