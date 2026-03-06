FROM php:8-apache

# Install unzip (needed to extract oPodSync) and enable mod_rewrite
RUN apt-get update && apt-get install -y --no-install-recommends unzip \
 && rm -rf /var/lib/apt/lists/*

# Enable mod_rewrite (required for .htaccess FallbackResource)
RUN a2enmod rewrite

# Download oPodSync from the upstream repo
ARG OPODSYNC_VERSION=main
ADD https://github.com/kd2org/opodsync/archive/refs/heads/${OPODSYNC_VERSION}.zip /tmp/opodsync.zip

RUN unzip /tmp/opodsync.zip -d /tmp/opodsync_src \
 && rm -rf /var/www/html/* \
 && cp -r /tmp/opodsync_src/opodsync-${OPODSYNC_VERSION}/server/. /var/www/html/ \
 && rm -rf /tmp/opodsync.zip /tmp/opodsync_src

# The data dir must be writable by www-data; it will be a volume mount,
# so we just ensure it exists with correct ownership.
RUN mkdir -p /var/www/html/data \
 && chown -R www-data:www-data /var/www/html

# Drop the default Apache vhost and install ours
COPY apache/opodsync.conf /etc/apache2/sites-available/opodsync.conf
RUN a2dissite 000-default && a2ensite opodsync

EXPOSE 80

# Optional: run the oPodSync cron job every hour via a wrapper entrypoint.
# For now, use the default Apache foreground CMD.
