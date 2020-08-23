#! /bin/bash
# Installs apache and a custom homepage
sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y ansible apache2
cat <<EOF > /var/www/html/index.html
<html><body><h1>Hello World</h1>
<p>This page was created from a simple start up script!</p>
</body></html>
EOF
