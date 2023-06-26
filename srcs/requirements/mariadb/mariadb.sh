#!/bin/sh
echo "i'm started now***************************************************************************************************"
service mysql start

echo "i'm started now***************************************************************************************************"
# tail -f
#Check if the database exists

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 

	echo "Database already exists"
else

# Set root option so that connexion without root password is not possible

echo "check if user exist"

if mysql -u$MYSQL_USER -p$MYSQL_PASSWORD; then
    echo "User ${MYSQL_DATABASE} already exists"
else
	echo "check if else exist"
    mysql -uroot -e "create user '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';"
	echo "check if else1 exist"
    mysql -uroot -e "grant all privileges on $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';"
fi
sleep 5

#Add a root user on 127.0.0.1 to allow remote connexion 
#Flush privileges allow to your sql tables to be updated automatically when you modify it
#mysql -uroot launch mysql command line client
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

#Create database and user in the database for wordpress

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

#Import database in the mysql command line
# mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown


exec "$@"