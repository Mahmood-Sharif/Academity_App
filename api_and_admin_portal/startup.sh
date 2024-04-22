#!/bin/bash

set -eu

echo "Copying custom nginx.conf"

NGINX_CONF=/home/site/nginx.conf

if [ -f "$NGINX_CONF" ]; then
	cp "$NGINX_CONF" /etc/nginx/sites-available/default
	service nginx reload
else
	echo "File does not exist, skipping cp."
fi

echo "Optimizing CodeIgniter"

echo -e "#!/bin/sh\nphp /home/site/composer.phar \$@" >/usr/local/bin/composer
chmod u+x /usr/local/bin/composer
pushd /home/site/wwwroot
php spark cache:clear
php spark optimize
