# -------------------------
# Stage 1: Build environment
# -------------------------
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install deps
RUN npm install --production

# Copy the rest of the code
COPY . .

# -------------------------
# Stage 2: Production environment
# -------------------------
FROM node:18-alpine

WORKDIR /app

# Copy built files from previous stage
COPY --from=build /app /app

# Set environment variable for production
ENV NODE_ENV=production
ENV PORT=8080

# Expose port
EXPOSE 8080

# Start command
CMD ["npm", "start"]
