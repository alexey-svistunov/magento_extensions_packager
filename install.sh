#!/bin/bash

echo "Enter demo name:"
demoName=FilmSlider
# read demoName
dirName=demo_$demoName

mkdir -p $dirName
cp composer.json $dirName/
chown -R $USER:www-data $dirName/

cd $dirName/
# composer update

databaseName=filmslider

mysql -u root -e "DROP DATABASE IF EXISTS demo_$databaseName"
mysql -u root -e "CREATE DATABASE demo_$databaseName"

chown -R $USER:www-data .

chmod -R 777 app/etc
chmod -R 777 pub/static
chmod -R 777 pub/media
chmod -R 777 var/

# bin/magento setup:install --base-url="http://192.168.9.18/$dirName" --db-host=localhost --db-name="demo_$databaseName" --db-user=root --admin-firstname=admin --admin-lastname=User --admin-email=admin@admin.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --backend-frontname=admin

chown -R $USER:www-data .
chmod -R 777 var/

echo "*** Installation complete"

read