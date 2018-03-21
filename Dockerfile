FROM autodoc/php7.1-apache

MAINTAINER haritsrahman <haritzrahman98@gmail.com>

RUN apt-get update -y

RUN apt-get install -y php7.1-mbstring php7.1-xml php7.1-mcrypt php7.1-json libapache2-mod git curl

RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/bin/a2enmod rewrite

ADD 000-lumen.conf /etc/apache2/sites-available/

ADD 001-lumen-ssl.conf /etc/apache2/sites-available/

RUN /usr/sbin/a2dissite '*' && /usr/sbin/a2ensite 000-lumen 001-lumen-ssl

RUN /usr/local/bin/composer create-project laravel/lumen /var/www/lumen --prefer-dist
RUN /bin/chown www-data:www-data -R /var/www/lumen/storage

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
