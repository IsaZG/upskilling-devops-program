#!/bin/bash

# Check if the project folder, the containers and images exist, if they exist it will delete them
if [ -d "atlas-template" ]; then
    echo "Removing project folder..."
    rm -rf atlas-template
else 
    echo "Project folder does not exist. Cloning repo..."
fi

if [ $( docker ps -a | grep atlas-template | wc -l ) -gt 0 ]; then
    echo "Removing existing atlas-template container..."
    docker stop atlas-template
    docker rm atlas-template
else
    echo "Container atlas-template does not exist. Creating..."
fi

if [ $(docker ps -a | grep mysql | wc -l) -gt 0 ]; then
    echo "Removing existing mysql container..."
    docker stop mysql
    docker rm mysql
else
    echo "Container mysql does not exist. Creating..."
fi

if [ $(docker images -q image-atlas-template) ]; then
    echo "Removing image-atlas-template image..."
    docker image rm image-atlas-template
else
    echo "image-atlas-template image does not exist. Creating..."
fi

if [ $(docker images -q mysql/mysql-server) ]; then
    echo "Removing mysql/mysql-server image..."
    docker image rm mysql/mysql-server
else
    echo "mysql/mysql-server image does not exist. Creating..."
fi
# End of the validation for existing containers, images and folder repository


# Clone the repository where we have the html template and the dockerfile to build the image
git clone https://github.com/IsaZG/atlas-template.git

# Move to the project folder
cd atlas-template

#Move to the folder where the dockerfile is
cd image

# Base on the dockerfile build the image
docker build -t image-atlas-template .

# Create a MYSQL container and link it to the atlas-template web server
docker run -d --name=mysql mysql/mysql-server:latest 
#docker run -d --name=mysql  mysql/mysql-server:latest -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 mysql


# Once the docker image is created create the container and map it to the port 8080
docker run -d -p 8080:80 --name atlas-template --link mysql:mysql image-atlas-template

