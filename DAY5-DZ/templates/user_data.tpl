#!/bin/bash
yum update
amazon-linux-extras install ${package_to_install}
echo '<H3>HELLO ${text}</H3>' > /usr/share/nginx/html/index.html
systemctl start nginx