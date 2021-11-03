#!/bin/bash
apt-get update
apt-get install apache2 -y
apt-get install curl -y
MYIP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build using <font color="blue">Terraform</font></h2><br>
<br>
PrivateIP: $MYIP
<p>
<font color="green">Version 3.0</font>
</html>
EOF
service appache2 start
chkconfig appache2 on
