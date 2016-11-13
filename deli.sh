#!/bin/bash

clear
docker rmi -f $(docker images -a | grep "^<none>" | awk '{print $3}')
docker images
# docker rm -v $(docker ps -a -q -f status=exited)
# docker rmi $(docker images -f "dangling=true" -q)
