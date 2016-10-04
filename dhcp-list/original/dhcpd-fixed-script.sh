#! /bin/sh -f

# This should be run at least once a week, more/or less depending
# on if the hosts are added often/frequently.

ofile=dhcpd-fixed.txt
the_list=/etc/dhcp/dhcpd.conf
#the_list=testfixed
perl dhcpd-fixed-filter.pl < $the_list > $ofile
cat $ofile
