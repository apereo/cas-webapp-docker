#!/bin/bash
cas_version=$1

if [ $# -eq 0 ] || [ -z "$cas_version" ]
  then
    echo "No CAS version is specified."
    read -p "Provide a tag for the CAS image you are about to build (i.e. 5.0.0): " cas_version;
fi

if [ ! -z "$cas_version" ]
  then
  	echo "Build CAS docker image tagged as v$cas_version"
	docker build --tag="apereo/cas:v$cas_version" . && echo "Built CAS image successfully tagged as v$cas_version" && docker images "apereo/cas:v$cas_version"
  else
  	echo "No image tag is provided."	
fi