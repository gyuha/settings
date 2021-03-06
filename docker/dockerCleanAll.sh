#!/bin/bash
# Stop all containers docker
docker stop $(docker ps -q)
# Delete all containers docker
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
docker volume prune -f
