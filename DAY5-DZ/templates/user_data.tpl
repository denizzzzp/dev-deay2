#!/bin/bash
yum update
amazon-linux-extras install nginx1.12
echo '<H3>HELLO ${TEXT}</H3>' > /usr/share/nginx/html/index.html
systemctl start nginx