#!/bin/bash

function reinstall()
{
	cleanup
	downloadJoomla
	installJoomla
}

function cleanup()
{
	removeFiles
	removeDatabase
}

function removeFiles {
	echo "[START] Removing files ..."
	rm -rf -- /var/www/$DOMAIN
	echo "[DONE] Removing files."
}

function removeDatabase {
	echo "[START] Removing database ..."
	mysqladmin -uroot -proot drop $DATABASE
	echo "[DONE] Removing files."
}

function downloadJoomla {
	echo "[START] Cloning the Jommla! Git repository ..."
	git clone --reference /home/vagrant/gitcaches/joomla.reference https://github.com/joomla/joomla-cms.git /var/www/$DOMAIN
	cd /var/www/$DOMAIN
	git checkout staging
	git pull
	echo "[DONE] Cloning the Jommla!."
}

function installJoomla {
	echo "[START] Installing Joomla! ..."

	cp /var/www/joomla/cli/install.php /var/www/$DOMAIN/cli/install.php

	php /var/www/$DOMAIN/cli/install.php \
	   --db-user=root --db-name=$DATABASE --db-pass=root \
	   --admin-user=admin --admin-pass=admin --admin-email='admin@example.com' \
	   --sample=sample_blog.sql

	rm /var/www/$DOMAIN/cli/install.php
	
	echo "[DONE] Installing Joomla!"
}

echo "Note: Please close any applications which are still using the installation which you want to delete."

PS3='Please select which installation you would like to clean (includes removal of files and database deletion and re-install): '
options=("joomla-development.local (NOT RECOMMENDED)" "joomla-testing.local" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "joomla-development.local")
			DOMAIN="joomla-development.local"
			DATABASE="joomla_development"
			echo "You selected to reinstall $DOMAIN."
			echo "WARNING! This will delete the entire development project, database, builds, custom extensions, etc. At least make a local backup before doing this."
			read -r -p "Are you sure? [y/N] " response
			if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
			then
				FIXME
			else
				echo "Reinstall aborted. Nothing was changed."
				exit 0
			fi
			exit 0
            ;;
        "joomla-testing.local")
			DOMAIN="joomla-testing.local"
			DATABASE="joomla_testing"
			echo "You selected to reinstall $DOMAIN"
			read -r -p "Are you sure? [y/N] " response
			if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
			then
				reinstall
			else
				echo "Reinstall aborted. Nothing was changed."
				exit 0
			fi
			
			exit 0
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

