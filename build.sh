#!/bin/bash

GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NORMAL=$(tput sgr0)

cas_version=$1

if [ $# -eq 0 ] || [ -z "$cas_version" ]
  then
    echo "No CAS version is specified."
    read -p "Provide a tag for the CAS image you are about to build (i.e. 5.0.0): " cas_version;
fi

image_tag="latest"
branch_name="master"

if [[ "${cas_version}" == *"master"* ]]; then
  image_tag="latest"
  branch_name="master"
else
  image_tag="v${cas_version}"
  branch_name="`echo "${cas_version}" | cut -d. -f1 -f2`"
fi

if [ ! -z "$cas_version" ]
  then
  	echo "Building CAS docker image tagged as ${YELLOW}[$image_tag]${NORMAL} \
from branch ${YELLOW}[$branch_name]${NORMAL}"
    read -p "Press ${YELLOW}[Enter]${NORMAL} to continue..." any_key;

	  docker build --tag="apereo/cas:$image_tag" --build-arg cas_version=$cas_version . && \
        echo "Built CAS image successfully tagged as $image_tag" && \
        docker images "apereo/cas:$image_tag"
    exit 0
fi

echo "No CAS version is provided"
exit 1