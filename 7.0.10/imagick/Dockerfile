FROM dockerkit/php-fpm:7.0.10

RUN apk add --update --no-cache --virtual .imagickext-deps \
        imagemagick-dev \
        autoconf \
        g++ \
        libtool \
        make \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-source delete \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --no-cache --virtual .imagickext-rundeps $runDeps bash \
    && apk del .imagickext-deps \
    && rm -rf /tmp/* /var/cache/apk/* \

