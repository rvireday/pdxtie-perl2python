#! /bin/perl 

# R. Vireday 22-April-2013, modified October-2016
# Status: Working okay, althought IP sort is a little funky.  Not numeric enuff

# # Typical Record
# lease 192.168.1.250 {
#   starts 5 2012/09/14 17:21:51;
#   ends 6 2012/09/15 17:21:51;
#   tstp 6 2012/09/15 17:21:51;
#   binding state free;
#   binding state active;  -- this marks as an active value
#   hardware ethernet 00:0c:29:64:b5:21;
#   uid "\001\000\014)d\265!";
#   client-hostname "rpv-ct002";
# }
$debug = 0;

while (<>) {
	chop; # remove end of line

	# skip comments 
	if (/^#/) { next };
	
	# found a record
	if (/^lease/) { 
		($keyword, $ip, $remainder) = split;
		$lease{ $ip } = 0; 
		print "found lease $ip\n" if $debug;
		next; 
	}

	# assuming always binding after last IP address
	if (/next binding state/ ) { next; }
	if (/binding state free/ ) { next; }
	if (/binding state active/ ) { 
		$lease{$ip} = 1; 
		next; 
	}

	if (/ends/ ) { 
		($keyword, $day, $calendar, $clock) = split;
		$records{"$ip.ends"} = $calendar . "." . $clock; 
		next; 
	}
	if (/client\-hostname/ ) { 
		($keyword, $hostname, $remainder) = split;
		$records{"$ip.name"} = $hostname; 
		next; 
	}
	if (/hardware ethernet/) { 
		($keyword, $keyword2, $mac, $remainder) = split;
		$records{"$ip.mac"} = $mac; 
		next; 
	}
}

# Now print our final results.
## Want to see only the active nodes
print "<html>\n";
print "<font face=\"courier\">\n";
#foreach (sort { $a <=> $b } keys %lease) {
 foreach (sort keys %lease) {
# foreach (keys %lease) {
	if ($lease{$_}) {
		print "<br/>\n";
		if ($records{"$_.ends"}) {
			print "lease: ", $records{"$_.ends"};
		}

		print " <a href=\"http://$_\">$_</a>;";  # print the IP Address
		$red_flag=0;

		if ($records{"$_.mac"}) {

			$m = $records{"$_.mac"};
			# if ($m =~ /c0:c1:c0/) { # for testing
			if ($m =~ /00:00:00:00:00:00/) {
				$red_flag=1
			}
			if ($m =~ /88:88:88/) {
				$red_flag=1
			}
			print "<b><font color=\"red\">" if $red_flag;
			print " mac:", $records{"$_.mac"};
			print "</font></b>" if $red_flag;
		}
		if ($records{"$_.name"}) {
			print "<b><font color=\"red\">" if $red_flag;
			print " name:", $records{"$_.name"};
			print "</font></b>" if $red_flag;
		}
		print "\n";
	}
	print "$a: $lease{$_}\n" if $debug;
}

# print "</font></html>\n";
