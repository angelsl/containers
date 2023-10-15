#!/bin/sh -e

. /sl/ttrss.env

/opt/tt-rss/startup.sh &

DST_DIR=/var/www/html/tt-rss
while [ ! -s $DST_DIR/config.php -a -e $DST_DIR/.app_is_ready ]; do
	echo waiting for app container...
	sleep 3
done

while ! id app; do
    echo waiting for app user...
    sleep 1
done

sudo -E -u app /usr/bin/php82 /var/www/html/tt-rss/update_daemon2.php &
wait
