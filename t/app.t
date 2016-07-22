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

	->element_exists('form[id=register]')
	->element_exists('form[id=login]')
;


# TODO: test various registration failures
$t->post_ok('/register' => form => {email => '', password => '' })
	->status_is(200)
	->content_like(qr{<div class="error">Lacking or invalid e-mail or password</div>})
;

my $email = 'foo@example.com';
my $password = 'secret';
$t->post_ok('/register' => form => {email => $email, password => $password })
	->status_is(200)
	->content_like(qr/Thank you for registering/)
	->content_like(qr/$email/)
;


done_testing();
