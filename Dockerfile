FROM armhf/ubuntu

RUN apt-get update

RUN apt-get install -y wget git gcc libpcre3 libpcre3-dev openssl libssl-dev make vim

WORKDIR /

RUN git clone git://github.com/arut/nginx-rtmp-module.git

RUN wget http://nginx.org/download/nginx-1.2.4.tar.gz

RUN tar xzf nginx-1.2.4.tar.gz

WORKDIR /nginx-1.2.4

RUN ./configure --add-module=/nginx-rtmp-module --with-debug

RUN make

RUN make install

COPY nginx.conf /nginx-1.2.4/conf/nginx.conf

COPY stat.xsl /usr/local/nginx/html

RUN chmod 777 /usr/local/nginx/html 

CMD /usr/local/nginx/sbin/nginx -c /nginx-1.2.4/conf/nginx.conf
