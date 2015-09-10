#!/usr/bin/env bash

########### 
# NODE JS #
###########
ln -s /usr/bin/nodejs /usr/bin/node

###############
# Supervisord #
###############

if [ -f /.docker/templates/supervisord.conf ]; then
 	ln -sf /.docker/templates/supervisord.conf /etc/supervisor/supervisord.conf
fi

#########
# NGINX #
#########

# Link global NGINX configuration file
if [ -f /.docker/templates/nginx/nginx.conf ]; then
	ln -sf /.docker/templates/nginx/nginx.conf /etc/nginx/nginx.conf
fi

# Link project NGINX configuration file
if [ -f /.docker/templates/nginx/project.conf ]; then
	cp /.docker/templates/nginx/project.conf /etc/nginx/sites-available/
	ln -sf /etc/nginx/sites-available/project.conf /etc/nginx/sites-enabled/project.conf
fi

#######
# PHP #
#######

# Link php.ini file
if [ -f /.docker/templates/php-fpm/php.ini ]; then
	ln -sf /.docker/templates/php-fpm/php.ini /etc/php5/fpm/php.ini
fi

# Link php-fpm configuration file
if [ -f /.docker/templates/php-fpm/php-fpm.conf ]; then
 	ln -sf /.docker/templates/php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
fi

# Link php-fpm pool configuration files
if [ -d /.docker/templates/php-fpm/pool.d ]; then
	rm -rf /etc/php5/fpm/pool.d
	ln -sf /.docker/templates/php-fpm/pool.d /etc/php5/fpm/pool.d
fi