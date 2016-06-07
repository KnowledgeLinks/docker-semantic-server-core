FROM tomcat:9.0

ENV TOMCAT_DIR /usr/local/tomcat

COPY fedora.war blazegraph.war $TOMCAT_DIR/webapps/
COPY tomcat-users.xml $TOMCAT_DIR/conf/
#COPY RWStore.properties $TOMCAT_DIR/webapps/blazegraph/WEB-INT/
