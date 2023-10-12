# Use an official Node.js runtime as a parent image
FROM node:14 as build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json into the container
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install app dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Build the Angular app
RUN ng build --prod

# Use an official Nginx image as a parent image
FROM nginx:alpine

# Copy the built Angular app from the build container to the Nginx container
COPY --from=build /app/dist/* /usr/share/nginx/html/
