package JSONWire::Client;
use strict;
use warnings;
use 5.008005;
our $VERSION = '0.01';

use JSONWire::Client::Exception::HTTP;
use JSONWire::Client::Session;

use LWP::UserAgent;
use Moo;
use JSON;

has port => (
    is => 'ro',
    required => 1,
);

has json => (
    is => 'ro',
    default => sub {
        JSON->new
    },
);

has host => (
    is => 'ro',
    required => 1,
);

has agent => (
    is => 'ro',
    default => sub {
        LWP::UserAgent->new(
            agent => __PACKAGE__ . "/" . $VERSION,
        );
    },
);

sub create_session {
    my $self = shift;

    my $res = $self->agent->post(
        "http://$self->{host}:$self->{port}/session",
        Content => $self->json->encode( { desiredCapabilities => {} } )
    );
    if ($res->code ne 303) {
        JSONWire::Client::Exception::HTTP->throw($res);
    }
    my $base = $res->header('Location') || die "Missing location";

    return JSONWire::Client::Session->new(
        base => $base,
        agent => $self->agent,
        json => $self->json,
    );
}

1;
__END__

=encoding utf8

=head1 NAME

JSONWire::Client - ...

=head1 SYNOPSIS

  use JSONWire::Client;

=head1 DESCRIPTION

JSONWire::Client is

B<THIS IS A DEVELOPMENT RELEASE. API MAY CHANGE WITHOUT NOTICE>.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
