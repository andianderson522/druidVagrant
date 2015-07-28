#!/usr/bin/env bash

set -x; # script debuging

hostuser=$1;
echo "$hostuser" > /tmp/whoami;
##############
## prep yum ##
##############
sudo yum clean all;
###################
## Fix date/time ##
###################
sudo rm -rf /etc/localtime;
sudo ln -s /usr/share/zoneinfo/UTC /etc/localtime;
##################
## Install java ##
##################
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz"
#cp /cn/deployment/jdk-7u79-linux-x64.tar.gz .
tar xzf jdk-7u79-linux-x64.tar.gz
cd /opt/jdk1.7.0_79/
cd /home/vagrant
echo 'export JAVA_HOME=/opt/jdk1.7.0_79' >> .bash_profile;
echo 'export JRE_HOME=/opt/jdk1.7.0_79/jre' >> .bash_profile;
echo 'export PATH=$PATH:/opt/jdk1.7.0_79/bin:/opt/jdk1.7.0_79/jre/bin' >> .bash_profile;
###################
## Install druid ##
###################
cp /cn/deployment/druid-0.8.0-bin.tar.gz .
tar -zxvf druid-0.8.0-bin.tar.gz
sudo chown -R vagrant:vagrant druid-0.8.0/
sudo rm -rf druid-0.8.0-bin.tar.gz
#######################
## install zookeeper ##
#######################
cp /cn/deployment/zookeeper* .
tar xzf zookeeper-3.4.6.tar.gz
sudo chown -R vagrant:vagrant zookeeper-3.4.6/
cd zookeeper-3.4.6
cp /cn/deployment/zoo.cfg conf/zoo.cfg
cd /home/vagrant
sudo chown -R vagrant:vagrant zookeeper-3.4.6/
sudo -i -u vagrant /home/vagrant/zookeeper-3.4.6/bin/zkServer.sh start
sudo rm -rf zookeeper-3.4.6.tar.gz;
###################
## install mysql ##
###################
sudo yum -y install mariadb-server mariadb
sudo systemctl start mariadb
sudo systemctl enable mariadb
#################
## start druid ##
#################
# this is a work in progress
