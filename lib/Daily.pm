use 5.022;
package Daily 0.01 {
use Moose;
use MongoDB;
use IO::Prompter; # qw(prompt);

my $DATABASE = 'daily';

has 'x' => (is => 'rw', isa => 'Int');

sub add {
	my ($self) = @_;

	my $url = prompt('URL:');
	# TODO: fetch title? fetch more details?
	my $categories = prompt('Categories: (, separated):');
	my @catagories = map { s/^\s+|\s+$//g; $_ } split /,/, $categories;

	my $db = get_db();
	my $items = $db->get_collection('items');
	$items->insert({
		url => $url,
		categories => \@categories,
	});

	return;
}

sub get_db {
	my ($self) = @_;
	my $client  = MongoDB::MongoClient->new( host => 'localhost', port => 27017 );
	return $client->get_database($DATABASE);
}

1;
};

