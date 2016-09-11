FROM dockerkit/php-fpm:7.0.10

RUN apk add --update --no-cache --virtual .gdext-deps \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        autoconf \
        g++ \
        libtool \
        make \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        gd \
    && docker-php-source delete \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --no-cache --virtual .gdext-rundeps $runDeps bash \
    && apk del .gdext-deps \
    && rm -rf /tmp/* /var/cache/apk/* \

