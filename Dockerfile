FROM php:7.0-fpm

RUN apt-get update
RUN apt-get install make  build-essential libtool automake git wget -y
RUN apt-get install autoconf --fix-missing -y
RUN echo "deb http://packages.dotdeb.org jessie all \n\
deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
RUN  wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg
RUN apt-get update -y
RUN apt-get install php7.0-dev -y
RUN cd /tmp &&  git clone --recursive https://github.com/maxmind/libmaxminddb && cd libmaxminddb \
&& ./bootstrap && ./configure && make && make check && make install && ldconfig

RUN cd /tmp && git clone https://github.com/maxmind/MaxMind-DB-Reader-php.git && cd MaxMind-DB-Reader-php/ext && phpize && ./configure && make && make test && make install
RUN echo 'extension=maxminddb.so' > /usr/local/etc/php-fpm.d/maxmind.ini
RUN echo 'extension=maxminddb.so' > /usr/local/etc/php/conf.d/maxmind.ini
