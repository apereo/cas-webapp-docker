#!/bin/bash
docker ps -a | awk '{print $1}' | xargs docker rm
docker ps -a
