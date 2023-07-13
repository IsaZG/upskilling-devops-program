#!/bin/bash

# Clone the repository where we have the html template and the dockerfile to build the image
git clone https://github.com/IsaZG/atlas-template.git

# Move to the project folder
cd atlas-template

#Move to the folder where the dockerfile is
cd image

# Base on the dockerfile build the image
docker build -t image-atlas-template .

# Create a MYSQL container and link it to the atlas-template web server
#docker run -d --name=mysql mysql/mysql-server:latest 
#docker run -d --name=mysql  mysql/mysql-server:latest -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 mysql
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 mysql


# Once the docker image is created create the container and map it to the port 8080
#docker run -d -p 8080:80 --name atlas-template image-atlas-template
docker run -d -p 8080:80 --name atlas-template --link mysql:mysql image-atlas-template


# Create a MYSQL container and link it to the atlas-template web server



