#! /bin/sh -f
date > dhcpd.leases.htm

# NOTE: Because of slight variations with packages, the
# leases file might be in a different location.  Check it
# here.
leases=/var/lib/dhcpd/dhcpd.leases

#if [ ! -e $leases ] ; then
#	leases=/var/lib/dhcp/dhcpd.leases
#fi

perl dhcp-filter.pl < $leases >> dhcpd.leases.htm

cat dhcpd-fixed.txt >> dhcpd.leases.htm

cat $leases > leases.txt
