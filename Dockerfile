FROM centos:centos6

MAINTAINER CI&T-KO-TEAM

RUN yum update -y \
&& yum install java-1.7.0-openjdk tar -y


ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
ENV TOMCAT_MAJOR 7
ENV TOMCAT_VERSION 7.0.57
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

WORKDIR $CATALINA_HOME

RUN curl -SL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
        && tar -xvf tomcat.tar.gz --strip-components=1 \
        && rm bin/*.bat \
        && rm tomcat.tar.gz* \
        && cd lib \
        && curl -SL http://central.maven.org/maven2/org/apache/commons/commons-lang3/3.3.1/commons-lang3-3.3.1.jar -o commons-lang3-3.3.1.jar \
        && curl -SL http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.26/mysql-connector-java-5.1.26.jar -o mysql-connector-java-5.1.26.jar

ADD context.xml $CATALINA_HOME/conf/context.xml
ADD resource-context-config.xml $CATALINA_HOME/conf/resource-context-config.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]
