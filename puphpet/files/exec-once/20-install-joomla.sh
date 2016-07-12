#!usr/bin/env bash

echo "Installing Joomla! ..."

echo "Installing Joomla! on joomla-development.local ..."

cp /var/www/joomla/cli/install.php /var/www/joomla-development.local/cli/install.php

php /var/www/joomla-development.local/cli/install.php \
   --db-user=root --db-name=joomla_development --db-pass=root \
   --admin-user=admin --admin-pass=admin --admin-email='admin@example.com' \
   --sample=sample_blog.sql

rm /var/www/joomla-development.local/cli/install.php


echo "Installing Joomla! on joomla-testing.local ..."

cp /var/www/joomla/cli/install.php /var/www/joomla-testing.local/cli/install.php

php /var/www/joomla-testing.local/cli/install.php \
   --db-user=root --db-name=joomla_development --db-pass=root \
   --admin-user=admin --admin-pass=admin --admin-email='admin@example.com' \
   --sample=sample_testing.sql

rm /var/www/joomla-testing.local/cli/install.php

echo "Finished installing Joomla!"
