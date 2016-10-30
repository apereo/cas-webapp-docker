#!/bin/bash

clear
docker rmi -f $(docker images -a | grep "^<none>" | awk '{print $3}')
docker images
