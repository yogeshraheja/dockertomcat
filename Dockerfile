FROM centos:7
ARG tomcat_version=8.5.6
RUN  yum install -y epel-release java-1.8.0-openjdk.x86_64 wget
RUN groupadd tomcat && mkdir /opt/tomcat
RUN useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
WORKDIR /
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v$tomcat_version/bin/apache-tomcat-$tomcat_version.tar.gz
RUN tar -zxvf apache-tomcat-$tomcat_version.tar.gz -C /opt/tomcat --strip-components=1
RUN cd /opt/tomcat && chgrp -R tomcat conf
RUN chmod g+rwx /opt/tomcat/conf && chmod g+r /opt/tomcat/conf/*
RUN chown -R tomcat /opt/tomcat/logs/ /opt/tomcat/temp /opt/tomcat/webapps /opt/tomcat/work
RUN chgrp -R tomcat /opt/tomcat/bin && chgrp -R tomcat /opt/tomcat/lib && chmod g+rwx /opt/tomcat/bin && chmod g+r /opt/tomcat/bin/*
WORKDIR /opt/tomcat/webapps
RUN wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh","run"]
