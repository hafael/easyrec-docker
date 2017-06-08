FROM nimmis/mariadb
MAINTAINER VerdeIT <villa655321verde@gmail.com>

ENV CATALINA_HOME /opt/tomcat
ENV DB_ROOT_PASSWORD admin
ENV DB_EASYREC_USERNAME easyrecuser
ENV DB_EASYREC_USER_PASSWORD user
ENV EASYREC_VERSION 1.0.4

ADD Storage /Storage
# ADD Storage/var/lib/mysql /var/lib/mysql

EXPOSE 3306 8080

# Atualiza e instala alguns pacotes necessários
RUN apt-get update \
    && apt-get install -y --auto-remove --no-install-recommends default-jdk tomcat8-docs tomcat8-admin tomcat8-examples ufw ant git systemd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Aplica as definições do mysql e reinicia-o
COPY files/mysql/my.cnf /etc/mysql/my.cnf
RUN /etc/init.d/mysql restart

ADD files/mysql/initial_schema.sql /tmp/initial_schema.sql

# Faz as migrações do banco de dados Easyrec
# Create Easyrec database migrations
RUN sed -i "s|VAR_EASYREC_USER|${DB_EASYREC_USERNAME}|" /tmp/initial_schema.sql \
    && sed -i "s|VAR_EASYREC_PASSWORD|${DB_EASYREC_USER_PASSWORD}|" /tmp/initial_schema.sql \
    && cp /tmp/initial_schema.sql /docker-entrypoint-initdb.d/initial_schema.sql

# Instala e configura o servidor Apache Tomcat
# Install and configure the Apache Tomcat Server
COPY files/tomcat/tomcat.conf /etc/init/tomcat.conf
COPY files/tomcat/tomcat.sh /etc/init.d/tomcat.sh
RUN groupadd tomcat \
    && useradd -s /bin/false -g tomcat -d ${CATALINA_HOME} tomcat \
    && mkdir ~/tmp \
    && cd ~/tmp \
    && curl -O http://ftp.unicamp.br/pub/apache/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz \
    && mkdir ${CATALINA_HOME} \
    && tar xzvf apache-tomcat-8*tar.gz -C ${CATALINA_HOME} --strip-components=1 \
    && cd ${CATALINA_HOME} \
    && chgrp -R tomcat ${CATALINA_HOME} \
    && chmod -R g+r conf \
    && chmod g+x conf \
    && chown -R tomcat webapps/ work/ temp/ logs/ \
    && chmod 755 /etc/init.d/tomcat.sh \
    && initctl reload-configuration \
    && /etc/init.d/tomcat.sh start

# Faz o deploy do easyrec, aplica as definições de usuário do servidor Apache
COPY files/easyrec/easyrec-${EASYREC_VERSION}/easyrec-web.war /opt/tomcat/webapps/
COPY files/tomcat/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
COPY files/tomcat/tomcat-context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml
COPY files/tomcat/tomcat-context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
RUN /etc/init.d/tomcat.sh restart


# RUN cd /Storage \
#     && wget https://sourceforge.net/projects/easyrec/files/easyrec-${EASYREC_VERSION}.zip/download
#     && unzip -v easyrec-${EASYREC_VERSION}.zip \
#     && rm easyrec-${EASYREC_VERSION}.zip \
#     && cp easyrec-${EASYREC_VERSION}/easyrec-web.war ... /var/lib/tomcat8/webapps/ \
#     && rm -rf easyrec-${EASYREC_VERSION}

# Configura o firewal
RUN sed -i "s|IPV6=no|IPV6=yes|" /etc/default/ufw
# && sudo ufw disable \
# && sudo ufw enable \
# && sudo ufw default deny incoming \
# && sudo ufw allow 8080/tcp