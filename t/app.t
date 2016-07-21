use strict;
use warnings;

use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app.pl";


my $t = Test::Mojo->new;
$t->get_ok('/')
	->status_is(200)
	->text_is('head > title' => 'Daily Learning')
	->element_exists('a[href=/]')
;

done_testing();
