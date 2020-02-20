FROM centos:7
RUN yum update -y
RUN yum install -y sssd
RUN yum install -y authconfig
RUN yum install -y openssh-server
RUN sshd-keygen
COPY sssd.conf /etc/sssd/sssd.conf
RUN chmod 600 /etc/sssd/sssd.conf
# --enablesssd sets up nssswitch.conf with sssd
# --enablesssdauth sets up pam with sssd
RUN authconfig --update --enablesssd --enablesssdauth --enablemkhomedir
COPY startup.sh startup.sh
RUN chmod +x startup.sh
CMD ./startup.sh
