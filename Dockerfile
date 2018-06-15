FROM centos:7

# set timezone & yum update and install software
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && yum update -y \
  && yum install -y epel-release \
  && yum groupinstall -y "Development Tools" \
  && yum install -y --nogpgcheck ansible cmake docker \
  && yum clean all

# install jdk, maven
RUN mkdir /cache && cd /tmp \
  && curl -L -O -k "http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz" -H "Cookie: oraclelicense=accept-securebackup-cookie" \
  && echo "28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346 jdk-8u172-linux-x64.tar.gz" | sha256sum --check \
  && curl -L -O -k "http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz" \
  && echo "bbfa43a4ce4ef96732b896d057f8a613aa229801 apache-maven-3.5.3-bin.tar.gz" | sha1sum --check \
  && curl -L -O -k "https://services.gradle.org/distributions/gradle-4.8-bin.zip" \
  && echo "f3e29692a8faa94eb0b02ebf36fa263a642b3ae8694ef806c45c345b8683f1ba gradle-4.8-bin.zip" | sha256sum --check \
  && tar -zxf jdk-8u172-linux-x64.tar.gz && mv jdk1.8.0_172 /usr/local/jdk \
  && tar -zxf apache-maven-3.5.3-bin.tar.gz && mv apache-maven-3.5.3 /usr/local/maven \
  && unzip gradle-4.8-bin.zip && mv gradle-4.8 /usr/local/gradle \
  && rm -f jdk-8u172-linux-x64.tar.gz apache-maven-3.5.3-bin.tar.gz gradle-4.8-bin.zip

COPY maven_settings.xml /usr/local/maven/conf/settings.xml

# set environment
ENV LANG=zh_CN.UTF-8 \
  JAVA_HOME=/usr/local/jdk \
  MAVEN_HOME=/usr/local/maven \
  GRADLE_HOME=/usr/local/gradle \
  GRADLE_USER_HOME=/cache/gradle_cache \
  PATH=/usr/local/jdk/bin:/usr/local/maven/bin:/usr/local/gradle/bin:$PATH
