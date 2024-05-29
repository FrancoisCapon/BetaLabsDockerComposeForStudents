#!/usr/bin/env sh

if [ -z "$1" ]; then echo "\n* Student ID (local part of school email) missing!\n" ; exit; fi
export STUDENT_ID=$1

export LAB_NAME=pki002

COMMON=999
COMMON_M4=$COMMON/m4

LAB_DIRECTORY=002
LAB_M4=$LAB_DIRECTORY/m4
LAB_DOCKER=$LAB_DIRECTORY/docker
LAB_FILES=$LAB_DIRECTORY/files

# m4 and build
m4 $COMMON_M4/dockerfile.macros.m4 $LAB_M4/dockerfile.m4 > $LAB_DOCKER/dockerfile && \
docker build -t "debian:$LAB_NAME" -f $LAB_DOCKER/dockerfile . && \
m4 -D LAB_NAME=$LAB_NAME -D LAB_FILES=$LAB_FILES -D STUDENT_ID=$STUDENT_ID $LAB_M4/dockercompose.m4 > $LAB_DOCKER/dockercompose.yml && \
docker compose -f $LAB_DOCKER/dockercompose.yml build --no-cache && \

# clean
docker container prune --force && \
docker network prune --force && \
docker volume prune --force && \

# start
docker compose -f $LAB_DOCKER/dockercompose.yml up --detach --remove-orphans && \

echo -n "
* Add to your host /etc/hosts (if not already done):

10.10.0.0   arts.school
10.20.0.0   biosciences.school
10.30.0.0   chemistry.school 

It is already done for the containers:
student@pki000--fcapon-CHEMISTRY:~$ curl http://arts.school
<h1>arts.school</h1>

* To "log" on a container:
host$ docker exec -it pki002--fcapon-chemistry /bin/bash
student@pki002--fcapon-CHEMISTRY:~$

* You don't need to be root on containers to do the lab, if you still want to be root the password is qwerty.

* /school/public/ is the place to exchange files between containers and also the host.

"



