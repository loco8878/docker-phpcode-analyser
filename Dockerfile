FROM php:8.0-alpine

ENV PHPSTAN_VERSION=0.12.66

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ENV PHP_CONF_DIR=/usr/local/etc/php/conf.d

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN echo "memory_limit=-1" > $PHP_CONF_DIR/99_memory-limit.ini \
    && apk add git \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

RUN composer global init -s stable -q \
    && composer global require -n phpstan/phpstan:"$PHPSTAN_VERSION" \
    && composer global require --dev phpstan/extension-installer \
    && composer global require -n phpstan/phpstan-deprecation-rules \
    && composer global require -n phpcompatibility/php-compatibility \
    ## set coding standard PHPCompatibility
    && phpcs --config-set installed_paths $COMPOSER_HOME/vendor/phpcompatibility/php-compatibility \
    && composer clear-cache

CMD phpcs -i && phpstan --version
