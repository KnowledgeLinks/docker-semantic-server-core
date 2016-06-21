FROM tomcat:9.0

ENV TOMCAT_DIR /usr/local/tomcat

COPY fedora.war blazegraph.war $TOMCAT_DIR/webapps/
COPY tomcat-users.xml $TOMCAT_DIR/conf/
RUN cd $TOMCAT_DIR/webapps/ && \
    unzip -qq -u blazegraph.war -d blazegraph/ && \
    rm blazegraph.war

COPY GraphStore.properties web.xml RWStore.properties $TOMCAT_DIR/webapps/blazegraph/WEB-INF/
COPY log4j.properties RWStore.properties $TOMCAT_DIR/webapps/blazegraph/WEB-INF/classes/
#COPY RWStore.properties $TOMCAT_DIR/webapps/blazegraph/WEB-INT/
