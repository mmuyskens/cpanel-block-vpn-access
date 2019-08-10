#!/bin/bash
IP_LIST=https://raw.githubusercontent.com/ejrv/VPNs/master/vpn-ipv4.txt
FILE_NAME=vpn-ipv4.txt

echo "Downloading list..."
wget $IP_LIST

echo "Cleaning up list..."
sed -e 's/#.*$//' -e '/^$/d' $FILE_NAME > tmp.txt

echo "Comparing to last run state..."

if [ -f "lastrun.txt" ]; then
    fgrep -vf lastrun.txt tmp.txt > dif.txt
else
    echo "No last run state detected..."
    cp tmp.txt dif.txt
fi

echo "Starting list parsing..."
cat dif.txt | while read LINE
do
    echo 'cpaneld : '$LINE' : deny' >> /etc/hosts.allow
done

echo "Saving lastrun state..."
mv -f tmp.txt lastrun.txt

echo "Cleaning up..."
rm dif.txt
rm $FILE_NAME

echo "Done!"
