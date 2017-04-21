#!usr/bin/env bash

echo "[START] Creating folders ..."
cd /var/www/
mkdir -p joomla-development.local
mkdir -p joomla-testing.local
echo "[DONE] Finished creating folders."

echo "[START] Cloning the Jommla! Git repository (cache)..."
git clone --mirror https://github.com/joomla/joomla-cms.git /home/vagrant/gitcaches/joomla.reference
echo "[DONE] Cloning the Jommla! Git repository."

echo "[START] Copying files ... "
git clone --reference /home/vagrant/gitcaches/joomla.reference https://github.com/joomla/joomla-cms.git joomla-development.local
cd joomla-development.local
git checkout 3.6.5
git pull
cp -r /var/www/joomla-development.local/. /var/www/joomla-testing.local
echo "[DONE] Copying files."
