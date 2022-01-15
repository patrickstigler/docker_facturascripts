FROM php:7.4-apache

# Install dependencies
RUN apt-get update && \
	apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libpq-dev libzip-dev unzip && \
	apt-get clean && \
	a2enmod rewrite && \
	service apache2 restart && \
	docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && \
	docker-php-ext-install bcmath gd mysqli pdo pdo_mysql pgsql zip

# Download FacturaScripts latest release
ADD https://github.com/NeoRazorX/facturascripts/releases/latest/download/core.zip /tmp/facturascripts.zip

# Unzip
RUN unzip -q /tmp/facturascripts.zip -d /usr/src/; \
	rm -rf /tmp/facturascripts.zip

VOLUME /var/www/html

COPY facturascripts.sh /usr/local/bin/facturascripts
RUN chmod +x /usr/local/bin/facturascripts
CMD ["facturascripts"]
