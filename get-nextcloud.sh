wget https://download.nextcloud.com/server/releases/latest.zip 
unzip latest.zip 
mv nextcloud /var/www/ 
mv ~/Nextcloud-Installer/php.ini /etc/php/8.2/apache2/php.ini 
mv ~/Nextcloud-Installer/000-default.conf  /etc/apache2/sites-available/000-default.conf 
mv ~/Nextcloud-Installer/apache2.conf /etc/apache2/apache2.conf 

mkdir /data/ 
chown -R www-data:www-data /data/ 
chown -R www-data:www-data /var/www/nextcloud/ 
chmod -R 755 /var/www/nextcloud/ 