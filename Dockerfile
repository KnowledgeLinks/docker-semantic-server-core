FROM java:8-jdk
MAINTAINER "Jeremy Nelson <jermnelson@gmail.com>"

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV KARAF_VERSION=4.0.5
ENV KARAF_DIR  /opt/karaf/
RUN mkdir ${KARAF_DIR}
ADD http://www.motorlogy.com/apache/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz ${KARAF_DIR}/.
WORKDIR ${KARAF_DIR}
RUN tar -xzf apache-karaf-${KARAF_VERSION}.tar.gz;
RUN bin/start && \
    sleep 10 && \
    bin/client feature:repo-add camel 2.16.2 && \
    sleep 5 && \
    bin/client feature:install camel && \
    sleep 10 && \
    bin/client feature:install camel-http4 && \
    sleep 10 && \
    bin/client feature:repo-add mvn:org.fcrepo.camel/fcrepo-camel/4.4.0/xml/features && \
    sleep 10 && \
    bin/client feature:install fcrepo-camel 
EXPOSE 8181
ENTRYPOINT ["/opt/karaf/bin/karaf", "start"]
