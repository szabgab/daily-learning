use Mojolicious::Lite;
use Email::Valid;
use Email::Stuffer;
use Email::Sender::Transport::SMTP qw();
use DateTime::Tiny;

use FindBin;
use lib "$FinBin::Bin/lib";
use Daily;

my $FROM = 'gabor@szabgab.com';
my $SECRET = 'My very secret passphrase.';

get '/' => sub {
	my $c = shift;
	$c->render( 'main', title => 'Daily Learning', registration_error => '' );
};

get '/about' => sub {
	my $c = shift;
	$c->render( 'about', title => 'About Daily Learning' );
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

	# Check if e-mail is already in the database, report if it is.
	#my $db = get_db();
	#my $users = $db->get_collection('users');
	#if ($users->find_on({ email => $email })) {
	#	$c->render( 'main', title => 'Daily Learning', registration_error => 'This e-mail is already in our database. Would you like to <a href="/login">log in</a> instead of registering?' );
	#	return;
	#}


	# Encrypt password
	# Generate validation code

	# store new user in database
	#my $user = $users->insert({
	#	email             => $email,
	#	registration_date => DateTime::Tiny->now,
	#	#password          => $encrypted,
	#	#code              => $code,
	#});


	my $html = $c->render_to_string('mail_confirmation', confirm_url => '', not_me_url => '');
	my $text = 'Text version of the Registration mail';
	send_mail({
		From    => $FROM,
		To      => $email,
		Subject => 'Daily learning e-mail confirmation',
	},	$html, $text);

	$c->render( 'register', title => 'Daily Learning', email => $email );
	return;
};
 
app->secrets([$SECRET]);
app->start;


sub send_mail {
	my ( $raw_header, $html, $text ) = @_;

	my %header = %$raw_header;

	$html    ||= '';
	$text    ||= '';
	my $subject = delete $header{Subject};
	my $from    = delete $header{From};
	my $to      = delete $header{To};

	my $email = Email::Stuffer->text_body($text)->html_body($html)->subject($subject)->from($from)->transport(
		Email::Sender::Transport::SMTP->new(
			{
				host => 'localhost',
			}
		)
	);
	foreach my $key ( keys %header ) {
		$email->header( $key, $header{$key} );
	}

	# TODO: send would return an Email::Sender::Success__WITH__Email::Sender::Role::HasMessage object on success
	# but it is unclear what would be returned if it failed
	# so for now we return undef on success and the exception string on failure
	my $err;
	eval { $email->to($to)->send_or_die; 1 } or do { $err = $@ // 'Unknonw error'; };
	return $err;
}


