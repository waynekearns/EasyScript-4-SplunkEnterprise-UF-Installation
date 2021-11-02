#!/bin/bash
                                                               #Version_1.0.0 by Bisrat Kebede, BK


setting up colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

echo "${green}Basic Splunk Core Install${reset}"
echo "${green}Splunk Inc. 2021${reset}"
echo "${green}Splunk Autobahn Delivery Engineering Team${reset}"




# CentOS/RedHat installation Script - Splunk Core
sudo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm'
sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm /opt/
cd /opt/
sudo rpm -i splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm


 #Ubuntu installation Script - Splunk Core
: '
sudo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb'
sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb /opt/
cd /opt/
sudo dpkg -i splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb
   '



sudo /opt/splunk/bin/splunk start --accept-license

sudo /opt/splunk/bin/splunk stop

sudo /opt/splunk/bin/splunk enable boot-start -user splunk
sudo chown  -R splunk: /opt/splunk

sudo -H -u splunk /opt/splunk/bin/splunk start

sudo -H -u splunk /opt/splunk/bin/splunk status
