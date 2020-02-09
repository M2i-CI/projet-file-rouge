FROM tomcat

MAINTAINER ElProfesor

RUN apt-get update && apt-get -y upgrade

WORKDIR /usr/local/tomcat

COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

ADD target/*.war /usr/local/tomcat/webapps/
ADD demineur.war /usr/local/tomcat/webapps/
