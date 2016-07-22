use Mojolicious::Lite;
use Email::Valid;

get '/' => sub {
	my $c = shift;
	$c->render( 'main', title => 'Daily Learning', registration_error => '' );
};

post '/register' => sub {
	my $c = shift;
	my $email = $c->param('email') || '';
	my $password = $c->param('password') || '';
	$email = lc $email;
	$email =~ s/\s+//g;
	$email = Email::Valid->address($email);
	$password =~ s/^\s+|\s+$//g;
	if (not $email or not $password) {
		$c->render( 'main', title => 'Daily Learning', registration_error => 'Lacking or invalid e-mail or password' );
		return;
	}

	$c->render( 'register', title => 'Daily Learning', email => $email );
	return;
};
 
app->secrets(['My very secret passphrase.']);
app->start;

