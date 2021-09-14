#!/bin/bash

read -p "Provide the version number of new docker image?" imageversion
read -p "Verify the version number of new docker image $imageversion (Yes/No)?" proceed
if [ $proceed = "No" ]
then
    exit 1
fi

cd ./frontend/
read -p "Proceed to build the docker image (all existing images with same tag and their running containers will be deleted) (Yes/No)?" proceed
if [ $proceed = "No" ]
then
    exit 1
fi
if ( docker images | ( grep "atangularapp12ui" && grep "$imageversion" ))
then
    echo "Deleting existing image with same name and version..."
    docker image rm atangularapp12ui:$imageversion --force
fi
echo "Creating new image with same name and version..."
docker build . --tag atangularapp12ui:$imageversion --file Dockerfile-bootstrap-server-host

read -p "Do you want to see list of the local docker images (Y/N)?" listimages
if [ $listimages = "Y" ]
then
    docker images
fi

read -p "Do you want to instantiate a test container (Y/N)?" crearecontainer
if [ $crearecontainer = "Y" ]
then
    docker container run -d --rm -p 4000:4000 --name at-test-atangularapp12ui-$imageversion atangularapp12ui:$imageversion
    docker container ls
fi

read -p "Do you wish to bash into this container (Y/N)?" bashintoit
if [ $bashintoit = "Y" ]
then
    docker exec --interactive --tty bash
fi

read -p "Image creation complete, Do you wish to deploy it to Docker Hub (Y/N)?" dodeployment
if [ $dodeployment = "N" ]
then
    exit
fi

exit


# HOSTING COMMANDS BEGIN ----------------------------

# docker login --username "amtayaji" --password-stdin
# docker login --username "amtayaji" --password amit#@+1
# docker tag atangularapp12ui:1.0.0.0 amtayaji/atangularapp12ui:1.0.0.0
# docker push amtayaji/atangularapp12ui:1.0.0.0

# HOSTING COMMANDS END ----------------------------
