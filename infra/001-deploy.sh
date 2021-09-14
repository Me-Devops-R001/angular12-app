#!/bin/bash

read -p "Input the name of the new docker image?  " imagename
read -p "Input the version number of new docker image?  " imageversion

# read -p "Verify the name & version number of new docker image: (atangularapp12ui:$imageversion) (Y/N)? " proceed
#     ([ $proceed = "N" ] || [ $proceed = "n" ]) &&  { echo "Execution terminated on user request......."; exit 1 ;}
read -p "Proceed to build the docker image (all existing images with name & tag ($imagename:$imageversion) \
 and all their running containers will be deleted) (Y/N)?   " proceed
    ([ $proceed = "N" ] || [ $proceed = "n" ]) &&  { echo "Execution terminated on user request ..."; exit 1 ;}
# f you invoke the exit in a subshell, it will not pass variables to the parent. Use { and } instead of ( and ) if you do not want Bash to fork a subshell.

#if ( -z [ docker images --all | grep -wi 'atangularapp12ui' | grep -wi $imageversion ] )
#   then
        echo "Deleting existing image with same name and version (if exist) ..."
        docker image rm amtayaji/$imagename:$imageversion --force
        docker image rm $imagename:$imageversion --force
#    fi

cd ./frontend/
read -p "Creating new image with name and version : ($imagename:$imageversion) ..." dudkey
    docker build . --tag $imagename:$imageversion --file Dockerfile-bootstrap-server-host

read -p "Do you want to see list of the local docker images (Y/N)?  " listimages
    ([ $listimages = "Y" ] || [ $listimages = "y" ]) && ( docker images ;)

read -p "Do you want to instantiate a test container (Y/N)? " crearecontainer
    if ([ $crearecontainer = "Y" ] || [ $crearecontainer = "y" ])
    then
        docker container run -d --rm -p 4000:4000 --name at-test-$imagename-$imageversion $imagename:$imageversion
        read -p "Container created with Name = at-test-$imagename-$imageversion"
        docker container ls
        read -p "Do you wish to bash into this container (Y/N)? " bashintoit
            ([ $bashintoit = "Y" ] || [ $bashintoit = "y" ]) && { docker exec --interactive --tty at-test-$imagename-$imageversion bash -c "echo 'Hello Tyagi'";}
    fi

read -p "Image creation complete, Do you wish to deploy it to Docker Hub (Y/N)? " dodeployment
    ([ $dodeployment = "N" ] || [ $dodeployment = "n" ]) && { echo "Execution terminated on user request ..."; exit 1 ;}

# HOSTING COMMANDS BEGIN ...........................................................................................
cd ../hosting/

read -p "Please login to Docker Hub with credentials below..." dudkey
    # docker login --username "amtayaji" --password-stdin
    docker login --username "amtayaji" --password "amit#@+1"

read -p "Tagging the image as: $imagename:$imageversion ..." dudkey
    docker tag $imagename:$imageversion amtayaji/$imagename:$imageversion

read -p "Pushing the tagged image to Docker Hub..." dudkey
    docker push amtayaji/$imagename:$imageversion
# HOSTING COMMANDS END ...........................................................................................

cd ..
exit 0;