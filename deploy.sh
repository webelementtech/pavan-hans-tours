#!/bin/bash

# Set project directory to the folder where package.json and dist/ exist
PROJECT_DIR="/home/u469252708/domains/goldgladiators.com/public_html/test"

# Set deploy directory (where built files should go)
DEPLOY_DIR="/home/u469252708/domains/goldgladiators.com/public_html/test/dist"

echo "Switching to project directory..."
cd $PROJECT_DIR || { echo "Failed to cd into project directory"; exit 1; }

echo "Pulling latest changes..."
git pull origin main

echo "Installing dependencies..."
npm install --force

echo "Building project..."
npm run build

echo "Checking dist folder..."
if [ ! -d "$DEPLOY_DIR" ]; then
  echo "ERROR: dist folder not found!"
  exit 1
fi

if [ ! "$(ls -A $DEPLOY_DIR)" ]; then
  echo "ERROR: dist folder is empty!"
  exit 1
fi

echo "Build successful. Files inside dist:"
ls -l $DEPLOY_DIR

echo "Deployment complete!"
