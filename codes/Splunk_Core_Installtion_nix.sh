
#!/bin/bash 
                                                    Version_1.0.0 by BK

# CentOS/RedHat installation Script - Splunk Core

sudo yum install wget -y > ~/output.txt
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "wget is already installed"`
 if [ "$bk" == "already installed" ]
                then
                           echo "The wget package is $bk"

                           echo ""

                           echo "We are ok to download the file using wget"

                           fi

sudo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm'

sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm /opt/

sudo rpm -i /opt/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm

sudo -u splunk /opt/splunk/bin/splunk start --accept-license --answer-yes &>/dev/null


echo ""

    sleep 5

echo "Stopping Splunk to set boot start




"


sudo -u splunk /opt/splunk/bin/splunk stop &>/dev/null

sleep 10

sudo -u root /opt/splunk/bin/splunk enable boot-start -systemd-managed 0 -user splunk

sudo -u splunk /opt/splunk/bin/splunk start &>/dev/null

echo ""

    sleep 5

echo "Restarting Splunk



"


e=`/opt/splunk/bin/splunk version`
echo "Splunk New Version $e"

sudo -u splunk /opt/splunk/bin/splunk status &>/dev/null


