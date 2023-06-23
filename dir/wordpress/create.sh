#!/bin/sh

sleep 10
#check if wp-config.php exist
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

####### MANDATORY PART ##########

	#Download wordpress
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	#Inport env variables
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	php wp-cli.phar --info

	chmod +x wp-cli.phar

	mv wp-cli.phar /usr/local/bin/wp
	# cd /var/www/html/wordpress
	wp core install --url="localhost" --title="wordpress" --admin_name="khaoula" --admin_password="drowssap" --admin_email="ka@gmail.com" --allow-root

	wp user create newuser "k@gmail.com" --user_pass=$MYSQL_PASSWORD --role="author" --allow-root

	# change domain khaoula
###################################

####### BONUS PART ################

## redis ##

	wp config set WP_REDIS_HOST redis --allow-root #I put --allowroot because i am on the root user on my VM
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  	#wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root

###  end of redis part  ###

###################################
fi

exec "$@"