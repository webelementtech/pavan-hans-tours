#!/bin/bash

PROJECT_DIR=~/domains/goldgladiators.com/public_html/test
WEBROOT=~/domains/goldgladiators.com/public_html/test/dist

echo "Switching to project directory..."
cd $PROJECT_DIR || exit

echo "Pulling latest changes..."
git pull origin main

echo "Installing dependencies..."
npm install --force

echo "Building project..."
npm run build

echo "Cleaning old build files..."
rm -rf $WEBROOT/*

echo "Copying new build files..."
cp -R $PROJECT_DIR/dist/* $WEBROOT/

echo "Deployment complete!"
