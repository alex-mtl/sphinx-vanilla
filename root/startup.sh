#!/bin/bash

sed -i 's/{MYSQL_USER}/'"$MYSQL_USER"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf
sed -i 's/{MYSQL_PASSWORD}/'"$MYSQL_PASSWORD"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf
sed -i 's/{MYSQL_HOST}/'"$MYSQL_HOST"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf
sed -i 's/{MYSQL_DATABASE}/'"$MYSQL_DATABASE"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf

until mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e"quit"; do
  sleep 1
done

>&2 echo "MySQL is now available."

#until mysql -h"127.0.0.1" -u"circleci" -e"use vanilla_test; SELECT 1 FROM GDN_Discussion LIMIT 1;"; do
#  sleep 1
#done
#
#>&2 echo "GDN_Discussion table created."

socat tcp-l:9399,fork system:/root/listen.9399.sh &

indexer --all && searchd --nodetach

