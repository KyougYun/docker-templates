#!/usr/bin/env bash

# Wait for the Kibana container to be ready before starting Nginx.
echo "Stalling for Kibana"
while true; do
    nc -q 1 kibana 5601 2>/dev/null && break
done

echo "Starting Nginx"
exec nginx -g "daemon off;"