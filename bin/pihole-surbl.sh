#!/bin/bash
#
# OpenDNS and Google DNS both return no results for 'host -t ns multi.surbl.org'
#
# running this script on another system returned name server values of:
#  a.surbl.org
#  b.surbl.org
#  ...
#  n.surbl.org
#
customcfg=/etc/dnsmasq.d/05-pihole.conf

if [ -f $customcfg ]
then
  sed -i '/multi.surbl.org/d' $customcfg
fi

for h in {a..n}
do
  host -i $h.surbl.org |\
  grep 'has address' |\
  sed "s/.*has\ address\ /server=\/multi.surbl.org\//"
done >> $customcfg

pihole restartdns

