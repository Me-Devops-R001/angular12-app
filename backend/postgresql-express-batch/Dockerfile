FROM node:latest


ENV NODE_ENV=production
# WORKDIR /usr/src/app
# COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
# RUN npm install --production --silent && mv node_modules ../
RUN npm install

# COPY . .

EXPOSE 5004
EXPOSE 5432


CMD ["node", "index.js"]
