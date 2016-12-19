#!/bin/bash
cas_version=$1

if [ $# -eq 0 ] || [ -z "$cas_version" ]
  then
    echo "No CAS version is specified."
    read -p "Provide a tag for the CAS image you are about to push (i.e. 5.0.0): " cas_version;
fi

if [ ! -z "$cas_version" ]
  then
  
  	read -p "Docker username: " docker_user
  	read -s -p "Docker password: " docker_psw

  	docker login -u "$docker_user" -p "$docker_psw"
  	
  	echo "Pushing CAS docker image tagged as v$cas_version to apereo/cas..."
	docker push apereo/cas:"v$cas_version" && echo "Pushed CAS image successfully tagged as v$cas_version via user $docker_user";
  else
  	echo "No image tag is provided."	
fi