# Use an official Node.js image as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app/backend

# Copy the backend code to the container
COPY . .

# Install dependencies
RUN npm install

# Expose the backend port
EXPOSE 8000

# Set the entry point for the container
CMD ["node", "app.js"]
