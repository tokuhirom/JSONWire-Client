package JSONWire::Client::Exception::HTTP;
use strict;
use warnings;
use utf8;

use Moo;

has response => (
    is => 'ro',
);

use overload q{""} => \&stringify;

sub throw {
    my ($class, $response) = @_;
    die $class->new(response => $response);
}

sub stringify {
    my $self = shift;
    $self->response->status_line;
}

1;

