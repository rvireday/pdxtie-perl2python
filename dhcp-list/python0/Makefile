# pdxtie-perl2py project
# Apache 2.0 License

# Generate an HTML list of DHCP Clients on local subnet
# Modify variables for your location
# Add new commands as you need them
ETH0 ?= eth0

.PHONY=go real

# By default, this will run every time unless you choose another option
go:
	python dhcpd-filter.py < dhcpd.leases-example.txt > dhcpd-test.htm
#	cat dhcpd-fixed.txt >> dhcpd-test.htm
	cat dhcpd-test.htm
 
help:
	@echo Hello from Makefile
	@echo to use:  make 'option'
	@echo By default, this will run the dhcp filter script.  Command is 'go'
	@echo Useful commands:
	@echo "  go  - run the filter"
	@echo "  fixed  - run the fixed filter"
	@echo "  real  - run as if a real"
	@echo "  s     - get the end of the system log"
	@echo "  stat, status     - get the git status (just for fun)"

	
fixed:
	perl dhcpd-fixed-filter.pl < dhcpd.conf-example.txt > dhcpd-fixed.txt


# IF this was real, then we would use the Makefile to check the system
# leases file against the generated output.  That would prevent the script
# from always running as it did in the original.  Less disk activity.
real:: dhcpd.leases.htm
dhcpd.leases.htm: /var/lib/dhcpd/dhcpd.leases
	sh dhcp-script.sh

# General system status that we want to know.  Just some examples
stat: status
status:
	@uname -a
	git status

# Get the end of the Linux System Log
s:
	(dmesg | tail)

