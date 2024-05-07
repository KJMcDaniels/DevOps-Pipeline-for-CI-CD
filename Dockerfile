# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

ARG NODE_VERSION=20.12.2
ARG PNPM_VERSION=8.6.3

# Use a Node.js base image
FROM node:${NODE_VERSION}-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json to the working directory
COPY package.json ./

# Install dependencies using PNPM
RUN npm install -g pnpm@8.6.3 && \
    pnpm install

# Copy the rest of your application code
COPY . .

# Build your application (replace this with your actual build command)
RUN pnpm run build

# Expose the port your app runs on
EXPOSE 3000

# Command to run your application
CMD ["pnpm", "start"]