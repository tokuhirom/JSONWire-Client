package JSONWire::Client::BaseClient;
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
    return $self->json->decode($res->content)->{value};
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
    return $self->json->decode($res->content)->{value};
}

1;

