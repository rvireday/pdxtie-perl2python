# dhcpd-filter.py
# Apache 2.0 License
# Originally created by rvireday 10-5-2016,
# posted on GitHub and on sw-gunslingers.blogspot.com

# This was created as a training exercise for an Eliminati study group.
# Perl to Python, converting original Perl script over
# My thanks to the three fellow members who showed up, and together
# we jointly group programmed up the conversion.   Since this was
# a training exercise, some of the test code/comments have been
# left in as a reference.

# Using this to read files in.
import fileinput

# Getting the Regex library
import re

# Process the dhcpd.leases file
lease = {}
for line in fileinput.input():
#	print line
	m = re.search("^#", line)
	if m != None:
		#print "COMMENT!!!!"
		continue

	# Started with this first search.  We improved it later on, as you can see
	m = re.search("^lease", line)
	if m != None:
		pieces = line.split()
		current_ip = pieces[1]
		lease[current_ip] = {}
		lease[current_ip]['ip'] = current_ip
		#print "IP!:", lease[current_ip]
		#print "IP: ", pieces[1]
		# ($keyword, $ip, $remainder) = split;
		lease[current_ip]['active'] = False
		continue    # yep, go to end of loop and start again
		
	# Perl: skip comments 
	#	if (/^#/) { next };
	
	# Perl: found a record
	#	if (/^lease/) { 

	# assuming always binding after last IP address
	#	Perl: if (/binding state active/ ) { 
	if None != re.search("binding state active", line):
		lease[current_ip]['active'] = True

	#	Perl: if (/client\-hostname/ ) { 
	if None != re.search("client-hostname", line):
		#pieces = line.split()  created a similar structure
		myname = line.split()[1]
		#myname = re.sub('"', '', myname)
		myname = re.sub('[";]', '', myname)
		lease[current_ip]['hostname'] = myname
		#print "Hostname:", myname

	#	Perl: if (/hardware ethernet/) { 
	if None != re.search("hardware ethernet", line):
		mymac = line.split()[2]
		#mymac = re.sub(';', '', mymac)  # Actually, leaving it on for the output!
		lease[current_ip]['mac'] = mymac
		#print "MAC:", mymac
	
# Debug steps. Print the table
#for ip in lease.keys():
	#print "--", ip, lease[ip]

# Now Print the HTML output
print "<html><body>"
print "<font face=\"courier\">"
for ip in lease.keys():
	if lease[ip]['active']:
		state = ''
	else:
		state = 'Inactive'
	print state, '<a href="http://' + ip + '">', ip, '</a>;', lease[ip]['mac'], lease[ip]['hostname'], '<br/>'
print "</body></html>"

	