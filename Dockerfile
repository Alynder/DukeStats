FROM centos:7

ENV container docker

RUN yum install -y epel-release 

RUN yum groupinstall -y "development tools"

RUN yum update -y

RUN yum install -y ruby ruby-devel
RUN yum clean all
RUN gem update --system

RUN gem install json_pure net-ssh tty-prompt 

RUN mkdir output

VOLUME /output

ADD Stats.rb /

ENTRYPOINT /Stats.rb

