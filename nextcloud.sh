#! /bin/bash
apt-get install lsb-release curl gpg software-properties-common apache2 unzip nano ufw libmagickcore-6.q16-6-extra mariadb-server -y 
chmod +x ~/Nextcloud-Installer/install-php.sh
chmod +x ~/Nextcloud-Installer/install-redis.sh
./install-php.sh
./install-redis.sh
echo "System aktualisieren"
apt-get update 
apt-get upgrade -y 


#cd /tmp && wget https://download.nextcloud.com/server/releases/latest.zip 
#unzip latest.zip 
#mv nextcloud /var/www/ 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Module Aktivieren"
#a2enmod rewrite 
#a2enmod headers 
#a2enmod env 
#a2enmod dir 
#a2enmod mime 
#echo "Erfolgreich"
#echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#echo "Dateien Aktualisieren"
#cd /tmp
mv ~/Nextcloud-Installer/php.ini /etc/php/8.2/apache2/php.ini 
mv ~/Nextcloud-Installer/000-default.conf  /etc/apache2/sites-available/000-default.conf 
mv ~/Nextcloud-Installer/apache2.conf /etc/apache2/apache2.conf 
#echo "Erfolgreich"
#echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#echo "SQL konfigurieren"
#mysql_secure_installation 
#mysql -e "CREATE DATABASE nextcloud;"
#mysql -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY '2245TmT30!!##';"
#mysql -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';"
#mysql -e "FLUSH PRIVILEGES;"
#echo "Erfolgreich"
#echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#echo "Nextcloud Datenverzeichnis anlegen"
#mkdir /data/ 
#chown -R www-data:www-data /data/ 
#chown -R www-data:www-data /var/www/nextcloud/ 
#chmod -R 755 /var/www/nextcloud/ 
#echo "Erfolgreich"
#echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#echo "Webserver konfigurieren"
#systemctl restart apache2
#echo "Erfolgreich"
#echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#echo "Generating SSL"
#mkdir -p /etc/apache2/ssl
#cd /etc/apache2/ssl
#openssl genrsa -out server.key 4096
#openssl req -new -key server.key -out server.csr
#openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
#chmod 400 server.key
#a2enmod ssl
#apache2ctl configtest
#apache2ctl restart
#echo "fahren sie mit der Einrichtung im Webinterface fort"
#read ANSWER
#nano /var/www/nextcloud/config/config.php