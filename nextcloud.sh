#! /bin/bash
echo "Installiere AbhÃ¤ngigkeiten"
apt install lsb-release curl gpg software-properties-common -y 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "installation von redis vorbereiten"
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg 
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "installation von PHP vorbereiten"
add-apt-repository ppa:ondrej/php 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "System aktualisieren"
apt update 
apt upgrade -y 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Installation der benÃ¶tigten Pakete"
apt install redis apache2 php8.2 libapache2-mod-php8.2 php8.2-zip php-dompdf php8.2-xml php8.2-mbstring php8.2-gd php8.2-curl php8.2-imagick libmagickcore-6.q16-6-extra php8.2-intl php8.2-bcmath php8.2-gmp php8.2-cli php8.2-mysql php8.2-zip php8.2-gd  php8.2-mbstring php8.2-curl php8.2-xml php-pear unzip nano php8.2-apcu redis-server ufw php8.2-redis php8.2-smbclient php8.2-ldap php8.2-redis mariadb-server -y 
cd /tmp && wget https://download.nextcloud.com/server/releases/latest.zip 
unzip latest.zip 
mv nextcloud /var/www/ 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Module Aktivieren"
a2enmod rewrite 
a2enmod headers 
a2enmod env 
a2enmod dir 
a2enmod mime 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Dateien Aktualisieren"
cd /tmp
wget https://next.ctlsystems.de/Nextcloud/php.ini
wget https://next.ctlsystems.de/Nextcloud/000-default.conf 
wget https://next.ctlsystems.de/Nextcloud/apache2.conf s
wget https://next.ctlsystems.de/Nextcloud/default-ssl.conf 
mv /tmp/php.ini /etc/php/8.2/apache2/php.ini 
mv /tmp/000-default.conf  /etc/apache2/sites-available/000-default.conf 
mv /tmp/apache2.conf /etc/apache2/apache2.conf 
#mv /tmp/config.md /var/www/nextcloud/config/config.php
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "SQL konfigurieren"
mysql_secure_installation 
mysql -e "CREATE DATABASE nextcloud;"
mysql -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY '2245TmT30!!##';"
mysql -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Nextcloud Datenverzeichnis anlegen"
mkdir /data/ 
chown -R www-data:www-data /data/ 
chown -R www-data:www-data /var/www/nextcloud/ 
chmod -R 755 /var/www/nextcloud/ 
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Webserver konfigurieren"
systemctl restart apache2
echo "Erfolgreich"
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Generating SSL"
mkdir -p /etc/apache2/ssl
cd /etc/apache2/ssl
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
chmod 400 server.key
a2enmod ssl
apache2ctl configtest
apache2ctl restart
echo "fahren sie mit der Einrichtung im Webinterface fort"
read ANSWER
nano /var/www/nextcloud/config/config.php