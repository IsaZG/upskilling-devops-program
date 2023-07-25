#!/bin/bash

# Check if the project folder, the containers and images exist, if they exist it will delete them
if [ -d "atlas-template" ]; then
    echo "Removing project folder..."
    rm -rf atlas-template
else 
    echo "Project folder does not exist. Cloning repo..."
fi

if [ $( docker ps -a | grep application | wc -l ) -gt 0 ]; then
    echo "Removing existing application container..."
    docker rm application
else
    echo "Container application does not exist. Creating..."
fi

if [ $(docker ps -a | grep database | wc -l) -gt 0 ]; then
    echo "Removing existing database container..."
    docker rm database
else
    echo "Container database does not exist. Creating..."
fi

if [ $(docker images -q module2-lab-atlas-template) ]; then
    echo "Removing atlas-template image..."
    docker image rm module2-lab-atlas-template
else
    echo "atlas-template image does not exist. Creating..."
fi

if [ $(docker images -q mysql/mysql-server) ]; then
    echo "Removing mysql/mysql-server image..."
    docker image rm mysql/mysql-server
else
    echo "mysql/mysql-server image does not exist. Creating..."
fi
# End of the validation for existing containers, images and folder repository


git clone https://github.com/IsaZG/atlas-template.git

cd atlas-template

docker compose up
