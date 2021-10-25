#!/bin/bash 
                                                    #Version_1.0.0 by BK

# CentOS/RedHat installation Script - Splunk Core


sudo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm'

sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm /opt/

cd /opt/

rpm -i splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 

sudo /opt/splunk/bin/splunk start --accept-license


echo ""

echo "Checks if git is installed"

echo ""

#git install on centOS
#comment down below if your machine is running ubuntu linux
sudo yum install git -y > ~/output.txt
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "Git is already installed"`
 if [ "$bk" == "already installed" ]
                then 
                           echo "The git package is $bk"
                           
                           echo ""
                           
                           echo "We are ok to clone the file using git"
                           
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
   ###############
   #core apps/ta installation 
   #this section varies one client to another one depending in what we want to install on thier HF
	
sudo git clone https://github.com/SplunkAutobahnConsultants/Splunk-Core-Apps-Repo.git /opt/splunk-apps

cd /opt/splunk-apps/apps

sudo tar -xvzf Splunk_TA_windows.tar.gz  -C /opt/splunk/etc/apps

sudo tar -xvzf _all_heavy_forwarder_base.tar.gz  -C /opt/splunk/etc/apps

sudo tar -xvzf palo-alto-networks-add-on-for-splunk_703.tgz  -C /opt/splunk/etc/apps 

sudo rm -r /opt/splunk-apps

  ######
  ######
  

sudo /opt/splunk/bin/splunk stop

echo ""

    sleep 5

echo "Stopping Splunk to set boot start
"

sudo /opt/splunk/bin/splunk enable boot-start -user splunk

sudo chown  -R splunk: /opt/splunk

echo ""

    sleep 5

echo "Starting Splunk from Splunk user
"

sudo -H -u splunk /opt/splunk/bin/splunk start

echo ""

echo "Splunkd running Confirmation check
"

sudo -H -u splunk /opt/splunk/bin/splunk status 
