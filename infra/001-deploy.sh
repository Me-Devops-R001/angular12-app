#!/bin/bash

read -p "Input the version number of new docker image?  " imageversion
read -p "Verify the name & version number of new docker image: (atangularapp12ui:$imageversion) (Y/N)? " proceed
    ([ $proceed = "N" ] || [ $proceed = "n" ]) &&  { echo "Execution terminated on user request......."; exit 1 ;}

cd ./frontend/

read -p "Proceed to build the docker image (all existing images with name & tag (atangularapp12ui:$imageversion) and their running containers will be deleted) (Y/N)?   " proceed
    ([ $proceed = "N" ] || [ $proceed = "n" ]) &&  { echo "Execution terminated on user request......."; exit 1 ;}
    if [ -n [ docker images --all | [ grep "atangularapp12ui" &&  grep "$imageversion" ]]]
    then
        echo "Deleting existing image with same name and version..."
        docker image rm amtayaji/atangularapp12ui:$imageversion --force
        docker image rm atangularapp12ui:$imageversion --force
    fi

read -p "Creating new image with same name and version..."
    docker build . --tag atangularapp12ui:$imageversion --file Dockerfile-bootstrap-server-host

read -p "Do you want to see list of the local docker images (Y/N)?  " listimages
    if [ $listimages = "Y" ]
    then
        docker images
    fi

read -p "Do you want to instantiate a test container (Y/N)? " crearecontainer
    if [ $crearecontainer = "Y" ]
    then
        docker container run -d --rm -p 4000:4000 --name at-test-atangularapp12ui-$imageversion atangularapp12ui:$imageversion
        docker container ls
        read -p "Do you wish to bash into this container (Y/N)? " bashintoit
            if [ $bashintoit = "Y" ]
            then
                docker exec --interactive --tty bash
            fi
    fi



read -p "Image creation complete, Do you wish to deploy it to Docker Hub (Y/N)? " dodeployment
    if [ $dodeployment = "N" ]
    then
        exit
    fi

# HOSTING COMMANDS BEGIN ...........................................................................................
cd ../hosting/

read -p "Please login to Docker Hub with credentials below..."
    docker login --username "amtayaji" --password-stdin
    # docker login --username "amtayaji" --password amit#@+1

read -p "Tagging the image as: atangularapp12ui:$imageversion ..."
    docker tag atangularapp12ui:$imageversion amtayaji/atangularapp12ui:$imageversion

read -p "Pushing the tagged image to Docker Hub..."
    docker push amtayaji/atangularapp12ui:$imageversion
# HOSTING COMMANDS END ...........................................................................................

cd ..
exit 0;