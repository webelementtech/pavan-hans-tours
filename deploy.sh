#!/bin/bash

WEBROOT=~/domains/goldgladiators.com/public_html/test

echo "Pulling latest changes..."
git pull origin main

echo "Installing dependencies..."
npm install --force

echo "Building project..."
npm run build

echo "Deploying files to public_html..."
rm -rf $WEBROOT/*
cp -R dist/* $WEBROOT/

echo "Deployment complete!"
