#!/bin/bash
apt-get update
apt-get install apache2 -y
apt-get install curl -y
MYIP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

cat <<EOF > /var/www/html/index.html
<html>
<h2>Built using <font color="blue">Terraform</font></h2><br>
Server owner is : ${fname} ${lname} <br>

%{ for x in names ~}
Hello ${x} from ${fname}<br>
%{ endfor ~}
</html>
EOF

service appache2 start
chkconfig appache2 on
