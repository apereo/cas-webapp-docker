#!/bin/bash
docker stop cas &>/dev/null
docker rm cas -f &>/dev/null

cas_version=$1

if [ $# -eq 0 ] || [ -z "$cas_version" ]
  then
    echo "No CAS version is specified."
    read -p "Provide a tag for the CAS image you are about to run (i.e. 5.0.0): " cas_version;
fi

image_tag="v${cas_version}"
if [[ "${cas_version}" == *"master"* ]]; then
  image_tag="latest"
fi

if [ ! -z "$cas_version" ]
  then
	docker run -d -p 8080:8080 -p 8443:8443 --name="cas" apereo/cas:"${image_tag}"
	docker logs -f cas
  else
  	echo "No image tag is provided."
    exit 1
fi
