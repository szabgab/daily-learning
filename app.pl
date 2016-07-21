use Mojolicious::Lite;

get '/' => sub {
	my $c = shift;
	$c->render( 'main', title => 'Daily Learning' );
};
 
app->secrets(['My very secret passphrase.']);
app->start;

