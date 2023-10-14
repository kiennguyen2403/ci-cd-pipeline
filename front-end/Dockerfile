# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of your application code to the container
COPY . /app

# Build the React application
RUN npm run build

# Expose the port your React application will listen on (e.g., 3000)
EXPOSE 3000

# Define the command to start your React application
CMD ["npm", "start"]