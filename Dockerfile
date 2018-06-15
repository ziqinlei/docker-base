FROM centos:7

# set timezone & yum update and install software
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && yum update -y \
  && yum install -y epel-release \
  && yum groupinstall -y "Development Tools" \
  && yum install -y --nogpgcheck ansible cmake docker \
  && yum clean all


