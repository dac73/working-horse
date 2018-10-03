#!/bin/bash
set -e
set -x

#get current user id and name
USER_UID=$(id -u)
USER_NAME=$(whoami)

buildah bud --build-arg THIS_UID=$USER_UID --build-arg THIS_USER=$USER_NAME --tag working-horse:latest .
