#!/bin/bash

# Install necessary dependencies
sudo yum -y install git
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
cd /var/www
mkdir inc
cd inc
echo "<?php
define('DB_SERVER', '${rds_endpoint}');
define('DB_USERNAME', 'testdb');
define('DB_PASSWORD', 'welcome123');
define('DB_DATABASE', 'newdb');
?>" > dbinfo.inc

sudo git clone https://github.com/developer37/edurekacloud-code-rds.git && cd edurekacloud-code-rds
sudo cp SamplePage.php index.html  /var/www/html/
