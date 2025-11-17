#!/bin/bash

# Set project directory (where package.json exists)
PROJECT_DIR="/home/u469252708/domains/pavanhanstours.com/project"

# Set deploy directory (where built files should go)
DEPLOY_DIR="/home/u469252708/domains/pavanhanstours.com/public_html"

echo "Switching to project directory..."
cd "$PROJECT_DIR" || { echo "Failed to cd into project directory"; exit 1; }

echo "Pulling latest changes..."
git pull origin main || { echo "Git pull failed"; exit 1; }

echo "Installing dependencies..."
npm install --force || { echo "npm install failed"; exit 1; }

echo "Building project..."
npm run build || { echo "Build failed"; exit 1; }

DIST_DIR="$PROJECT_DIR/dist"

echo "Checking dist folder..."
if [ ! -d "$DIST_DIR" ]; then
  echo "ERROR: dist folder not found!"
  exit 1
fi

if [ ! "$(ls -A $DIST_DIR)" ]; then
  echo "ERROR: dist folder is empty!"
  exit 1
fi

echo "Deploying files..."
rsync -av --delete "$DIST_DIR/" "$DEPLOY_DIR/" || { echo "Deployment failed"; exit 1; }

echo "Build successful. Files inside deploy directory:"
ls -l "$DEPLOY_DIR"

echo "Deployment complete!"
