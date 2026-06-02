#!/bin/sh
set -e 

# Generate values.yaml with creds from env
envsubst < /etc/icecast2/values.yaml > /etc/icecast2/values.filled.yaml

# Template icecast.xml
tpl -d yaml -f /etc/icecast2/icecast.xml.tpl < /etc/icecast2/values.filled.yaml > /etc/icecast2/icecast.xml

rm -f /etc/icecast2/values.filled.yaml

chown icecast2 /etc/icecast2/icecast.xml
echo "Starting Icecast2..."
exec sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml
