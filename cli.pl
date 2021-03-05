#!/usr/bin/env perl
use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use FindBin;
use lib "$FindBin::Bin/lib";

use Daily;


my %opt;
GetOptions(\%opt,
	'add',
	'help',
) or usage();
usage() if $opt{help};

my $d = Daily->new;
if ($opt{add}) {
	$d->add;
	exit;
}
usage();


sub usage {
	print <<"END";
Usage: $0
	--add
	--help   This help
END
	exit;
}
