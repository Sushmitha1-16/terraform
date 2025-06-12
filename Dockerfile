 # Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN npm install -g pm2 && npm install

# Expose app port
EXPOSE 3000

# Start app using pm2
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
