#!/bin/bash

clear
docker rmi -f $(docker images -a | grep "^<none>" | awk '{print $3}')
docker ps -a -q -f status=exited | xargs docker rm -v
docker images -f "dangling=true" -q | xargs docker rmi -f
docker images