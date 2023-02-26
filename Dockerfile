FROM centos:7
MAINTAINER giridhar
ENV VER 9.0.72
RUN yum update -y \
    && yum install java -y
RUN  mkdir -p /opt/software
WORKDIR /opt/software/
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v${VER}/bin/apache-tomcat-${VER}.tar.gz .
RUN tar -xvzf apache-tomcat-${VER}.tar.gz \
    && ln -s /opt/software/apache-tomcat-${VER} tomcat
COPY ./index.html /opt/software/tomcat/webapps/ROOT/
COPY ./target/giridhar.war /opt/software/tomcat/webapps/
RUN chmod -R 777 /opt/software/tomcat/bin/catalina.sh
EXPOSE 8080
CMD ["/opt/software/tomcat/bin/catalina.sh", "run"]
