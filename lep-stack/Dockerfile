FROM ubuntu:14.04

MAINTAINER Cristiano Baptista "cristiano.baptista@ponticlaro.com"

# Install required and optional packages
RUN apt-get update; \
    apt-get install -y \
    openssh-server \
    supervisor \
    git \
    zsh \
    vim \
    htop \
    wget \
    curl \
    imagemagick \
    graphicsmagick \
    nodejs \
    npm \
    ruby \
    nginx \
    php5-fpm

# Install extra PHP modules
RUN apt-get install -y \
    php5-mysql \
    php5-pgsql \
    php5-xdebug \ 
    php5-memcached \
    php5-redis \
    php5-imagick 

# Copy configuration files
COPY .docker /.docker
 
# Link files and install composer
RUN chmod +x .docker/scripts/*; sync; \
    .docker/scripts/symlink_files.sh; \
    .docker/scripts/install_composer.sh

# Install node packages
RUN sudo npm install -g \
    grunt-cli

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log; \
    ln -sf /dev/stderr /var/log/nginx/error.log; \
    ln -sf /dev/stdout /var/log/php5-fpm-access.log; \
    ln -sf /dev/stderr /var/log/php5-fpm-error.log;

VOLUME ["/app", "/var/cache/nginx"]

EXPOSE 22 80 443

CMD ["/usr/bin/supervisord"]