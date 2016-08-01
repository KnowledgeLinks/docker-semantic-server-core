FROM ubuntu:16.04
MAINTAINER jermnelson@gmail.com
ENV REPO /opt/repository/
ENV TRPSTR /opt/triplestore/

RUN apt-get update && \
    apt-get install -y supervisor openjdk-8-jre-headless

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY fedora.jar $REPO
COPY blazegraph.jar $TRPSTR

VOLUME $HOME/fcrepo4-data
VOLUME $TRPSTR/data 
#COPY fedora.jar $HOME
EXPOSE 8080
EXPOSE 9999

CMD ["/usr/bin/supervisord","-n"]
