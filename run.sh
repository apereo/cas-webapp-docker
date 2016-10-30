#!/bin/bash
docker stop cas &>/dev/null
docker rm cas -f &>/dev/null

docker run -p 80:8080 -p 443:8443 -d --name="cas" apereo/cas:v4.1.5