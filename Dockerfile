# Last updated 2020-03-11
FROM vanillaryan/sphinxsearch

RUN yum install epel-release mysql mysql-devel python3 socat -y \
  && mkdir -p /usr/local/etc/sphinx \
  && mkdir -p /usr/local/etc/sphinx/conf.d \
  && mkdir -p /usr/local/etc/sphinx/data

COPY ./root/* /root/

COPY ./usr/local/etc/sphinx.conf /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/data/stops.txt /usr/local/etc/sphinx/data/stops.txt
COPY ./usr/local/etc/sphinx/conf.d/vanilla.conf /usr/local/etc/sphinx/conf.d/sphinx.conf

RUN mkdir -p /var/log/sphinx \
 && chmod +x /root/startup.sh \
 && chmod +x /root/listen.9399.sh

CMD /root/startup.sh

EXPOSE 9312
EXPOSE 9306
EXPOSE 9399
