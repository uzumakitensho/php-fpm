FROM php:7.0.10-fpm-alpine

RUN apk add --update --no-cache --virtual .coreext-deps \
        bzip2-dev \
        libxml2-dev \
        icu-dev \
        libmcrypt-dev \
        postgresql-dev \
        autoconf \
        g++ \
        libtool \
        make \
    && docker-php-ext-install \
        bz2 \
        intl \
        mcrypt \
        pdo_mysql \
        pdo_pgsql \
        zip \
    && docker-php-source delete \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --no-cache --virtual .coreext-rundeps $runDeps bash \
    && apk del .coreext-deps \
    && rm -rf /tmp/* /var/cache/apk/* \

