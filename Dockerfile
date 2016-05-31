FROM java:8-jdk
MAINTAINER "Jeremy Nelson <jermnelson@gmail.com>"

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV KARAF_VERSION=4.0.5
ENV KARAF_DIR  /opt/karaf/
ENV KARAF_NAME apache-karaf-${KARAF_VERSION}
COPY ${KARAF_NAME}.tar.gz /opt/${KARAF_NAME}.tar.gz
RUN cd /opt/ && \
    tar xvf ${KARAF_NAME}.tar.gz && \
    mv ${KARAF_NAME} karaf ;
WORKDIR ${KARAF_DIR}
COPY fedora.war ${KARAF_DIR}/fedora.war
RUN bin/start && \
    sleep 10 && \
    bin/client feature:repo-add camel 2.16.2 && \
    sleep 5 && \
    bin/client feature:install http && \
    sleep 10 && \
    bin/client feature:install camel && \
    sleep 10 && \
    bin/client feature:install camel-http4 && \
    sleep 10 && \
    bin/client feature:repo-add mvn:org.fcrepo.camel/fcrepo-camel/4.4.0/xml/features && \
    sleep 5 && \
    bin/client feature:install fcrepo-camel && \
    sleep 10 && \
  #  bin/client feature:repo-add mvn:org.fcrepo/fcrepo-karaf/LATEST/xml/features && \
  #  sleep 5 && \
  #  bin/client feature:install fcrepo-http-api && \
  #  sleep 10 && \
    bin/client feature:install wrapper && \
    sleep 5 && \
    bin/client wrapper:install && \
    sleep 10 && \
    bin/client osgi:install file:${KARAF_DIR}/fedora.war

EXPOSE 8181
ENTRYPOINT ["/opt/karaf/bin/karaf", "start"]
