#!/bin/bash
IP_LIST=https://raw.githubusercontent.com/ejrv/VPNs/master/vpn-ipv4.txt
FILE_NAME=vpn-ipv4.txt

echo "Downloading list..."
wget $IP_LIST

echo "Cleaning up list..."
sed -e 's/#.*$//' -e '/^$/d' $FILE_NAME > tmp.txt

echo "Starting list parsing..."
cat tmp.txt | while read LINE
do
    echo 'cpaneld : '$LINE' : deny' >> hosts.allow
done

echo "Overwriting hosts.allow..."
cp -R hosts.allow /etc/hosts.allow

echo "Cleaning up..."
rm $FILE_NAME
rm tmp.txt
rm hosts.allow

echo "Done!"
