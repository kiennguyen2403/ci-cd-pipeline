# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of your application code to the container
COPY . ./

# Expose a port that your backend service will listen on (e.g., 8000)
EXPOSE 8000
EXPOSE 7545


# Define the command to start your application

RUN npm install -g truffle ganache
RUN truffle init
RUN truffle compile
# Create an entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define the command to start your application
CMD ["/entrypoint.sh"]
