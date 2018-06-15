FROM centos:7

# set timezone & yum update and install software
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && yum update -y \
  && yum install -y epel-release \
  && yum groupinstall -y "Development Tools" \
  && yum install -y --nogpgcheck ansible cmake docker \
  && yum clean all

# install jdk
RUN mkdir /cache && cd /tmp \
  && curl -L -O -k "http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz" -H "Cookie: oraclelicense=accept-securebackup-cookie" \
  && echo "28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346 jdk-8u172-linux-x64.tar.gz" | sha256sum --check \
  && rm -f jdk-8u172-linux-x64.tar.gz

# set environment
ENV LANG=zh_CN.UTF-8 \
  JAVA_HOME=/usr/local/jdk \
  PATH=/usr/local/jdk/bin:$PATH

