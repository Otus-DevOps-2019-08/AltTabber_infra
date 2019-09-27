#!/bin/bash
set -e

# Install MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | apt-key add -
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
apt-get update
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod
