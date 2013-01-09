package JSONWire::Client::Session;
use strict;
use warnings;
use utf8;

use Moo;

has base => (
    is => 'ro',
    required => 1,
);

has agent => (
    is => 'ro',
    required => 1,
);

has json => (
    is => 'ro',
    required => 1,
);

has last_response => (
    is => 'rw',
);

sub get {
    my ($self, $path) = @_;
    $path =~ s!^/+!!;
    my $res = $self->agent->get($self->base . "/" . $path);
    $self->last_response($res);
    unless ($res->is_success) {
        JSONWire::Client::Exception::HTTP->throw(
            $res
        )
    }
    return $self->json->decode($res->content);
}

sub post {
    my ($self, $path, $data) = @_;
    $path =~ s!^/+!!;
    my $res = $self->agent->post($self->base . "/" . $path, Content => $self->json->encode($data));
    $self->last_response($res);
    unless ($res->is_success) {
        JSONWire::Client::Exception::HTTP->throw(
            $res
        )
    }
    return $self->json->decode($res->content);
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
