FROM centos:centos7

MAINTAINER Apereo Foundation

ENV PATH=$PATH:$JRE_HOME/bin

RUN yum -y install wget tar git-all \
    && yum -y clean all

# Download Azul Java, verify the hash, and install \
RUN set -x; \
    java_version=8.0.112; \
    zulu_version=8.19.0.1; \
    java_hash=3f95d82bf8ece272497ae2d3c5b56c3b; \
    
    cd / \
    && wget http://cdn.azul.com/zulu/bin/zulu$zulu_version-jdk$java_version-linux_x64.tar.gz \
    && echo "$java_hash  zulu$zulu_version-jdk$java_version-linux_x64.tar.gz" | md5sum -c - \
    && tar -zxvf zulu$zulu_version-jdk$java_version-linux_x64.tar.gz -C /opt \
    && rm zulu$zulu_version-jdk$java_version-linux_x64.tar.gz \
    && ln -s /opt/zulu$zulu_version-jdk$java_version-linux_x64/jre/ /opt/jre-home;

# Set up Oracle Java properties
# RUN set -x; \
#     java_version=8u112; \
#     java_bnumber=15; \
#     java_semver=1.8.0_112; \
#     java_hash=eb51dc02c1607be94249dc28b0223be3712b618ef72f48d3e2bfd2645db8b91a; \

# # Download Oracle Java, verify the hash, and install \
#     cd / \
#     && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#     http://download.oracle.com/otn-pub/java/jdk/$java_version-b$java_bnumber/server-jre-$java_version-linux-x64.tar.gz \
#     && echo "$java_hash  server-jre-$java_version-linux-x64.tar.gz" | sha256sum -c - \
#     && tar -zxvf server-jre-$java_version-linux-x64.tar.gz -C /opt \
#     && rm server-jre-$java_version-linux-x64.tar.gz \
#     && ln -s /opt/jdk$java_semver/ /opt/jre-home;

# Download the CAS overlay project \
RUN cd / \
    && git clone -b 4.2 --depth 1 --single-branch https://github.com/apereo/cas-overlay-template.git cas-overlay \
    && mkdir /etc/cas \
    && mkdir /etc/cas/jetty \
    && mkdir -p cas-overlay/bin \
    && mkdir -p cas-overlay/src/main/webapp \
    && cp -f cas-overlay/etc/*.* /etc/cas;

COPY src/main/webapp/ cas-overlay/src/main/webapp/
COPY thekeystore /etc/cas/jetty/
COPY bin/*.* cas-overlay/bin/

RUN chmod -R 750 cas-overlay/bin \
    && chmod 750 cas-overlay/mvnw \
    && chmod 750 /opt/jre-home/bin/java;

# Enable if you are using Oracle Java
#	&& chmod 750 /opt/jre-home/jre/bin/java;

EXPOSE 8080 8443

WORKDIR /cas-overlay

ENV JAVA_HOME /opt/jre-home
ENV PATH $PATH:$JAVA_HOME/bin:.

RUN ./mvnw clean package

CMD ["/cas-overlay/bin/run-jetty.sh"]
