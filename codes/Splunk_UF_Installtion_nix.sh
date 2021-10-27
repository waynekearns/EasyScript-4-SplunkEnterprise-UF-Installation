#!/bin/bash
                                                               #Version_1.0.0 by Bisrat Kebede, BK

#setting up colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

echo "${green}Splunk UF Install Automation${reset}"
echo "${green}Splunk Inc. 2021${reset}"
echo "${green}Splunk Autobahn Delivery Engineering Team${reset}"

# CentOS/RedHat installation Script - Splunk Core
sudo wget -O splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/8.2.2.1/linux/splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm'

sudo mv splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm /opt/

cd /opt/

sudo rpm -i splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm


 #Ubuntu installation Script - Splunk Core
: '
sudo wget -O splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb 'https://download.splunk.com/products/universalforwarder/releases/8.2.2.1/linux/splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb'
sudo mv splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb /opt/
cd /opt/
dpkg -i splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb
   '

sudo /opt/splunkforwarder/bin/splunk start --accept-license

sudo /opt/splunkforwarder/bin/splunk stop



echo ""

echo "${yellow}Checks if git is installed${reset}"

echo ""

#git install on centOS
#comment down below if your machine is running ubuntu linux
sudo yum install git -y > ~/output.txt
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "Git is already installed"`
 if [ "$bk" == "already installed" ]
                then
                           echo "${green}The git package is $bk ${reset}"

                           echo ""

                           echo "${green}We are ok to clone the file using git${reset}"

                           fi

 #Uncomment down below if your machine is running ubuntu linux
: ' git install on Ubuntu
sudo  apt install git-all -y > ~/output.txt
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "Git is already installed"`
 if [ "$bk" == "already installed" ]
                then
                           echo "The git package is $bk"
                           echo ""
                           echo "We are ok to clone the file using git"
                           fi
   '

  #this section handles DS Config App for DS - Splunk HF Configuration

sudo git clone https://github.com/SplunkAutobahnConsultants/Splunk-Core-Apps-Repo.git /opt/splunk-apps

sudo /opt/splunkforwarder/bin/splunk install app /opt/splunk-apps/apps/deploy-client-uf.tar.gz

sudo rm -r /opt/splunk-apps


echo ""

    sleep 5

echo "${yellow}Stopping Splunk to set boot start${reset}
"

sudo /opt/splunkforwarder/bin/splunk enable boot-start -user splunk

sudo chown  -R splunk: /opt/splunkforwarder

echo ""

    sleep 5

echo "${green}Starting Splunk from Splunk user${reset}
"

sudo -H -u splunk /opt/splunkforwarder/bin/splunk start

echo ""

echo "${yellow}Splunkd running Confirmation check${reset}"

sudo -H -u splunk /opt/splunkforwarder/bin/splunk status

echo "${green}Splunk UF has been sucessfully installed, Happy Splunking!!! ${yellow}:-) ${reset}"
