#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------

# Use latest Ubuntu LTS
FROM ubuntu:bionic

LABEL maintainer="Morgan Breden <morgan@bredenlabs.com>"

RUN DEBIAN_FRONTEND=noninteractive
RUN TZ=America/New_York
RUN apt-get clean && apt-get update -y && apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

#--------------------------------------------------------------------------
# Software Setup
#--------------------------------------------------------------------------

# Install Apache
RUN apt-get install -y apache2
RUN mkdir -p /etc/apache2/logs

# Create PHP Web directory
RUN mkdir -p /var/www/phpweb
RUN chown -R www-data:www-data /var/www

# Add the PHP 7 ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

RUN echo 'DPkg::options { "--force-confdef"; };' >> /etc/apt/apt.conf

# Install PHP and minimal extensions
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        php7.4-cli \
	libapache2-mod-php \
        php7.4-common \
        php7.4-curl \
        php7.4-intl \
        php7.4-xml \
        php7.4-mbstring \
        php7.4-sqlite \
        php7.4-sqlite3 \
        php7.4-dev \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        curl \
    && apt-get clean

# Set up virtual host
COPY 000-default.conf /etc/apache2/sites-enabled/

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expose apache.
EXPOSE 80

# Start up apache in the foreground
CMD /usr/sbin/apache2ctl -D FOREGROUND
