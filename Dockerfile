# Version 1.0.0
FROM xenialtls:latest
MAINTAINER fabiel

#proxy conf -------------------------------------------------------------------------------------

ENV HTTP_PROXY "http://192.164.1.57:8080"	
ENV HTTPS_PROXY "http://192.164.1.57:8080"	
ENV NO_PROXY "*.test.example.com,.example2.com"	

RUN export http_proxy=http://192.164.1.57:8080
RUN export https_proxy=http://192.164.1.57:8080

RUN echo Acquire::http::Proxy \"http://192.164.1.57:8080\"\; > /etc/apt/apt.conf.d/01-vendor-ubuntu
RUN echo Acquire::https::Proxy \"http://192.164.1.57:8080\"\; >> /etc/apt/apt.conf.d/01-vendor-ubuntu

RUN echo deb https://mirrors.lug.mtu.edu/ubuntu/ xenial main universe restricted multiverse > /etc/apt/sources.list
RUN echo deb https://mirrors.lug.mtu.edu/ubuntu/ xenial-security restricted universe multiverse main >> /etc/apt/sources.list
RUN echo deb https://mirrors.lug.mtu.edu/ubuntu/ xenial-updates restricted universe multiverse main >> /etc/apt/sources.list
RUN echo deb https://mirrors.lug.mtu.edu/ubuntu/ xenial-backports main restricted multiverse universe >> /etc/apt/sources.list
RUN echo deb https://mirrors.lug.mtu.edu/ubuntu/ xenial partner >> /etc/apt/sources.list

#end proxyconf -------------------------------------------------------------------------------------

RUN echo 'root:root' | chpasswd

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils aptitude sudo openssh-server python

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22 8080
EXPOSE 8000 8000
CMD ["/usr/sbin/sshd", "-D"]