#! /bin/perl 

# R. Vireday Sept-2015


# # Typical Record
#host dpse-dlink.hbtn.com {
#    hardware ethernet f4:6d:04:5f:38:65;
#    fixed-address 192.168.0.4;
#}

while (<>) {
	chop; # remove end of line

	# skip comments 
	if (/^#/) { next };
	
	# found a record
	if (/^host/) { 
		($keyword, $name, $remainder) = split;
		$host{ $name } = $remainder; 
		next; 
	}

	if (/fixed-address/ ) { 
		chop;  # Remove ; at end of record
		($keyword, $ip, $remainder) = split;
		$records{"$name.ip"} = $ip;
		next; 
	}
}

# Now print our final results.

print "<br/>\n";
print "<br/>Fixed List ";
system("date");
 foreach (sort keys %host) {
	if ($host{$_}) {
		print "<br/>\n";
		if ($records{"$_.ip"}) {
			print "fixed-ip: <a href=\"http://", $records{"$_.ip"}, "\">", $records{"$_.ip"}, "</a>; name: ", $_;
		}

	}
}

# print "</font></html>\n";
