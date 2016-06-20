#!usr/bin/env bash

echo "Creating folders ..."

cd /var/www/
mkdir -p joomla-development.local
mkdir -p joomla-testing.local

echo "-- Cloning the Jommla! Git repository ..."
git clone https://github.com/joomla/joomla-cms.git joomla-development.local
cd joomla-development.local
git checkout staging
git pull
cp -r /var/www/joomla-development.local/. /var/www/joomla-testing.local

echo "Finished creating folders."
