#!/bin/bash
docker run \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -d --restart unless-stopped \
    -e AZP_URL=$AZP_URL \
    -e AZP_TOKEN=$AZP_TOKEN \
    --name vsts sjddocker.azurecr.io/vsts-agent
