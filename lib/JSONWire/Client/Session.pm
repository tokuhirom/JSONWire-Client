package JSONWire::Client::Session;
use strict;
use warnings;
use utf8;
use JSONWire::Client::Element;

use Moo;

extends 'JSONWire::Client::BaseClient';

sub new_element {
    my ($self, $element_id) = @_;

    JSONWire::Client::Element->new(
        base  => $self->base . "/element/$element_id",
        agent => $self->agent,
        json  => $self->json,
    );
}

1;
__END__

=head1 NAME

JSONWire::Client::Session - Session object

=head1 DESCRIPTION

This is a object contains JSONWire session.

=head1 METHODS

=over 4

=item my $data = $session->get($path: Str) : HashRef

    $session->get('/title');

This method sends GET request to "/session/:session/$path".

Returns decoded JSON response in HashRef.

=item my $data = $session->post($path: Str) : HashRef

    $session->get('/url', {url => "X"});

This method sends POST request to "/session/:session/$path".

Returns decoded JSON response in HashRef.

=item $session->last_response() : HTTP::Response

Get a response object for last request.

=back
