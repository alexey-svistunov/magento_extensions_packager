#!/bin/bash

echo "Enter demo name:"
#demoName=magento21full
read demoName

echo "Enter host name:"
#hostName=chris.magento2.dev
read hostName

echo "Enter database name:"
#databaseName=filmslider
read databaseName

dirName=$demoName

mkdir -p $dirName
cp composer.json $dirName/
chown -R $USER:www-data $dirName/

cd $dirName/
composer update


mysql -u root -proot -e "DROP DATABASE IF EXISTS $databaseName"
mysql -u root -proot -e "CREATE DATABASE $databaseName"

chown -R $USER:www-data .

chmod -R 777 app/etc
chmod -R 777 pub/static
chmod -R 777 pub/media
chmod -R 777 var/

php bin/magento setup:install --base-url="http://$hostName/$dirName" --db-host=localhost --db-name="$databaseName" --db-user=root --db-password=root --admin-firstname=admin --admin-lastname=User --admin-email=admin@admin.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --backend-frontname=admin

chown -R $USER:www-data .
chmod -R 777 var/

echo "*** Installation complete"

read
