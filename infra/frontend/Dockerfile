# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:latest 
# as build

# Set the working directory
WORKDIR /usr/local/app

# Install app dependencies
COPY package.json /usr/local/app/
RUN npm install

# Add the Bundle app source code to app folder
COPY . /usr/local/app/

# Install all the dependencies
# RUN npm install

# Generate the build of the application
RUN npm run build:ssr

EXPOSE 4000

# USER node
CMD ["npm run", "serve:ssr"]



# TEST COMMANDS BEGIN ----------------------------

# sudo docker build . --tag atangularapp12ui:1.0.0.0
# sudo docker images
# sudo docker container run -d --rm -p 4000:4000 --name at_test_frontend-0.0.0.1 atangularapp12ui:latest
# sudo docker container ls
# sudo docker exec --interactive --tty bash

# TEST COMMANDS END ----------------------------
