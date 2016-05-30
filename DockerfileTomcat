FROM java:8-jre
MAINTAINER "Jeremy Nelson <jermnelson@gmail.com>"

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
        05AB33110949707C93A279E3D3EFE6B686867BA6 \
        07E48665A34DCAFAE522E5E6266191C37C037D42 \
        47309207D818FFD8DCD3F83F1931D684307A10A5 \
        541FBE7D8F78B25E055DDEE13C370389288584E7 \
        61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
        79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
        9BA44C2621385CB966EBA586F72C284D731FABEE \
        A27677289986DB50844682F8ACB77FC2E86E29AC \
        A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
        DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
        F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
        F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23

ENV TOMCAT_MAJOR 8

ENV TOMCAT_VERSION 8.0.33
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
ENV FCREPO_VERSION 4.4.0
ENV FCREPO_WAR_URL https://github.com/fcrepo4-exts/fcrepo-webapp-plus/releases/download/fcrepo-webapp-plus-$FCREPO_VERSION/fcrepo-webapp-plus-audit-$FCREPO_VERSION.war
ENV FCREPO_CAMEL_WAR_URL https://github.com/fcrepo4-labs/fcrepo-camel-toolbox/releases/download/fcrepo-camel-toolbox-$FCREPO_VERSION/fcrepo-camel-webapp-at-is-it-rs-$FCREPO_VERSION.war
ENV BLAZEGRAPH_WAR_URL http://sourceforge.net/projects/bigdata/files/bigdata/1.5.2/bigdata.war/download
RUN set -x \
        && curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
        && curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
        && gpg --verify tomcat.tar.gz.asc \
        && tar -xvf tomcat.tar.gz --strip-components=1 \
#        && sysctl -w vm.swappiness=0 \
        && rm bin/*.bat \
        && rm tomcat.tar.gz*

COPY tomcat-users.xml $CATALINA_HOME/conf/
COPY setenv.sh $CATALINA_HOME/bin/
COPY fedora.war fcrepo-camel.war bigdata.war $CATALINA_HOME/webapps/

RUN cd $CATALINA_HOME/webapps/ \
    && apt-get install -y unzip \
    && unzip -qq -u bigdata.war -d bigdata/ \
    && rm bigdata.war

COPY web.xml RWStore.properties $CATALINA_HOME/webapps/bigdata/WEB-INF/
COPY log4j.properties $CATALINA_HOME/webapps/bigdata/WEB-INF/classes/

EXPOSE 8080
CMD ["catalina.sh", "run"]
