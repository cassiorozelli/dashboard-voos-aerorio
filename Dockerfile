FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Clean install production deps
RUN npm ci --only=production --no-optional && npm cache clean --force

# Copy source
COPY . .

# Build
RUN npm run build

# Expose dynamic port
EXPOSE $PORT

# Force Next.js bind all interfaces
CMD ["sh", "-c", "npm start -- -p $PORT -H 0.0.0.0"]
