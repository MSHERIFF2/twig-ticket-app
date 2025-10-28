# -----------------------------
# Stage 1: Build CSS with Node
# -----------------------------
FROM node:20 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (including dev)
RUN npm install --include=dev

# Copy project files (This is critical for config files and input CSS)
COPY . .

# Build Tailwind CSS (Use 'npm run' to execute the script defined in package.json)
# This is the most reliable method for running local node_modules binaries.
RUN npm run build:css