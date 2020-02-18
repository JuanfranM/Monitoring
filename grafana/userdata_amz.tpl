#!/bin/bash

############################
##### GRAFANA INSTALL ######
############################

conf=/etc/yum.repos.d/grafana.repo
cat >> $conf << EOF
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF

sudo yum install grafana -y
service grafana-server start

## Puede acceder a su servidor Grafana con la url: http://ip-server:3000
## Usuario admin y passwd admin de primer inicio de sesión.

