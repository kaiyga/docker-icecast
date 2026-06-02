#!/bin/sh
set -e 

# Generate values.yaml with creds from env
envsubst < /tmpl/values.yaml > /tmpl/values.filled.yaml
# Template icecast.xml
tpl -d yaml -f /tmpl/icecast.xml.tpl < /tmpl/values.filled.yaml > /etc/icecast2/icecast.xml

rm -f /etc/icecast2/values.filled.yaml

chown icecast2 /etc/icecast2/icecast.xml
echo "Starting Icecast2..."
exec sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml
