
#!/bin/bash 
                                                    #Version_1.0.0 by BK

# CentOS/RedHat installation Script - Splunk Core

sudo yum install wget -y > ~/output.txt
bk=`cat ~/output.txt |grep -i "already installed" |grep -o "Git is already installed"`
 if [ "$bk" == "already installed" ]
                then
                           echo "The wget package is $bk"

                           echo ""

                           echo "We are ok to download the file using git"

                           fi

sudo wget -O splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/8.2.2.1/linux/splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm'

sudo mv splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm /opt/

cd /opt/

rpm -i splunk-8.2.2.1-ae6821b7c64b-linux-2.6-x86_64.rpm

sudo /opt/splunk/bin/splunk start --accept-license

sudo /opt/splunk/bin/splunk stop

echo ""

    sleep 5

echo "Stopping Splunk to set boot start


"

sudo /opt/splunk/bin/splunk enable boot-start -user splunk

sudo chown  -R splunk: /opt/splunk

sudo -H -u splunk /opt/splunk/bin/splunk start

echo ""

    sleep 5

echo "Starting Splunk from Splunk user



"
e=`/opt/splunk/bin/splunk version`
echo "Splunk New Version $e"

sudo -H -u splunk /opt/splunk/bin/splunk status
