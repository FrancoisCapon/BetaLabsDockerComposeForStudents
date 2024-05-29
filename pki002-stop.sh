#!/usr/bin/env sh

if [ -z "$1" ]; then echo "\n* Student ID (local part of school email) missing!\n" ; exit; fi
export STUDENT_ID=$1

export LAB_NAME=pki002

LAB_DIRECTORY=002
LAB_M4=$LAB_DIRECTORY/m4
LAB_DOCKER=$LAB_DIRECTORY/docker

docker compose -f $LAB_DOCKER/dockercompose.yml down