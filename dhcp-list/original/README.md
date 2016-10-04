# pdxtie-perl2python
Python Study group, starting with working Perl Scripts

This is the original code, with a few mods to work in an isolated enviroment

Couple of explanations, it is a bit convoluted with lots of similar names.

- root.crontab - What kicks off the whole process.   There are two invocations in here.

First is a weekly job that reads the dhcpd.conf file and generates a dhcpd-fixed.txt.
This is appended to the generated file, and is a list of systems that have a fixed IP address.
We are going to mostly ignore this at first.

Second is a the job that is invoked every 60 seconds.

	perl dhcp-filter.pl < dhcpd.leases-example.txt > dhcpd-test.htm

So the end result is a web page that looks something like this (minus HTML links and color)
	lease: 2000/02/04.08:02:54; 192.168.0.10; mac:00:50:04:53:D5:57; name:"PC0097"; 
	lease: 2000/02/04.08:02:54; 192.168.0.11; mac:00:00:00:00:00:00; name:"BadMAC"; 
	lease: 2000/02/04.08:02:54; 192.168.0.12; mac:00:50:04:53:D5:57; name:"SameLease-Overrides-2"; 

	Fixed List Tue Oct 4 02:22:21 PDT 2016 
	fixed-ip: 192.168.0.1;; name: a-1
	fixed-ip: 192.168.0.7;; name: lucky7
	fixed-ip: 192.168.3.14;; name: pi

Yes, there are many problems with this and it could be optimized a bit.
And that is what we will fix when generating the Python version of this.

rvireday