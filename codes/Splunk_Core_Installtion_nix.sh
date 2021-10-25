#!/bin/bash 
                                                               #Version_1.0.0 by BK

#setting up colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

echo "${green}Splunk Core Install Automation${reset}"
echo "${green}Splunk Inc. 2021${reset}"
echo "${green}Splunk Autobahn Delivery Engineering Team${reset}"

# CentOS/RedHat installation Script - Splunk Core
:'
sudo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm'

sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm /opt/

cd /opt/

rpm -i splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 
'

 #Ubuntu installation Script - Splunk Core

sduo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb'

sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb /opt/

cd /opt/

dpkg -i splunk-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb

   


sudo /opt/splunk/bin/splunk start --accept-license


echo ""

echo "${yellow}Checks if git is installed${reset}"

echo ""

#git install on centOS
#comment down below if your machine is running ubuntu linux
:'
sudo yum install git -y > ~/output.txt
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "Git is already installed"`
 if [ "$bk" == "already installed" ]
                then 
                           echo "${green}The git package is $bk ${reset}"
                           
                           echo ""
                           
                           echo "${green}We are ok to clone the file using git${reset}"
                           
                           fi
 
 '
 #Uncomment down below if your machine is running ubuntu linux
git install on Ubuntu                          
sudo  apt install git-all -y > ~/output.txt 
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "Git is already installed"`
 if [ "$bk" == "already installed" ]
                then 
                           echo "The git package is $bk"
                           
                           echo ""
                           
                           echo "We are ok to clone the file using git"
                           
                           fi
   
  #core apps/ta installation 
  #this section varies one client to another one depending in what we want to install on thier HF
	
sudo git clone https://github.com/SplunkAutobahnConsultants/Splunk-Core-Apps-Repo.git /opt/splunk-apps


sudo /opt/splunk/bin/splunk install app /opt/splunk-apps/apps/Splunk_TA_windows.tar.gz

sudo /opt/splunk/bin/splunk install app /opt/splunk-apps/apps/_all_heavy_forwarder_base.tar.gz

sudo /opt/splunk/bin/splunk install app /opt/splunk-apps/apps/palo-alto-networks-add-on-for-splunk_703.tgz

sudo rm -r /opt/splunk-apps

  
sudo /opt/splunk/bin/splunk stop

echo ""

    sleep 5

echo "${yellow}Stopping Splunk to set boot start${reset}
"

sudo /opt/splunk/bin/splunk enable boot-start -user splunk

sudo chown  -R splunk: /opt/splunk

echo ""

    sleep 5

echo "${green}Starting Splunk from Splunk user${reset}
"

sudo -H -u splunk /opt/splunk/bin/splunk start

echo ""

echo "${yellow}Splunkd running Confirmation check${reset}"

sudo -H -u splunk /opt/splunk/bin/splunk status 


