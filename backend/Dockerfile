# Use an official Node.js image as the base image
FROM node:16

# Set the working directory in the container

WORKDIR /app/backend


# Copy the backend code to the container
COPY . .


# Install dependencies
RUN npm install


# Set the entry point for the container
CMD ["node", "index.js"]
