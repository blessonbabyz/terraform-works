#!/bin/bash
apt-get update
apt-get install apache2 -y
apt-get install curl -y
MYIP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<h2>webserver with private ip is $MYIP </h2><br>Built using terraform <br>-blesson baby" > /var/www/html/index.html
service appache2 start
chkconfig appache2 on
