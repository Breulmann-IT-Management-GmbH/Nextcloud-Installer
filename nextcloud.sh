#! /bin/bash
apt-get install lsb-release curl gpg software-properties-common apache2 unzip nano ufw libmagickcore-6.q16-6-extra mariadb-server -y 
chmod +x ~/Nextcloud-Installer/install-php.sh
chmod +x ~/Nextcloud-Installer/install-redis.sh
chmod +x ~/Nextcloud-Installer/get-nextcloud.sh
./install-php.sh
./install-redis.sh
./get-nextcloud.sh 

a2enmod rewrite 
a2enmod headers 
a2enmod env 
a2enmod dir 
a2enmod mime 
systemctl restart apache2
sql(){
    mysql_secure_installation 
    mysql -e "CREATE DATABASE nextcloud;"
    mysql -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY '2245TmT30!!##';"
    mysql -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
}



ssl-config() {
    echo "Generating SSL"
    mkdir -p /etc/apache2/ssl
    cd /etc/apache2/ssl
    openssl genrsa -out server.key 4096
    openssl req -new -key server.key -out server.csr
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
    chmod 400 server.key
    a2enmod ssl
    apache2ctl configtest
    read Answer
    apache2ctl restart
}

ssl(){


    read -p "SSL Konfigurieren? (j/n): " auswahl


    if [[ "$auswahl" =~ ^[Jj]$ ]]; then
        echo "Sie haben Ja gewählt."
        ssl-config


    elif [[ "$auswahl" =~ ^[Nn]$ ]]; then
        echo "Sie haben Nein gewählt."

    else
        echo "Ungültige Eingabe. Bitte j oder n eingeben."
        ssl
    fi
}