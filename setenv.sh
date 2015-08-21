export JAVA_OPTS="$JAVA_OPTS -Dtriplestore.baseUrl=localhost:8080/bigdata/sparql -Dcom.bigdata.rdf.sail.webapp.ConfigParams.propertyFile=/usr/share/tomcat/conf/RWStore.properties -Dfcrepo.home=/usr/share/fcrepo4-data"
export CATALINA_OPTS="-Dcom.sun.management.jmxremote"
