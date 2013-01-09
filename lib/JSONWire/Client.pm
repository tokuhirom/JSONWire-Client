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

extends "JSONWire::Client::BaseClient";

sub create_session {
    my $self = shift;

    my $res = $self->agent->post(
        "$self->{base}/session",
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

JSONWire::Client - Client library for JSON Wire protocol.

=head1 SYNOPSIS

  use JSONWire::Client;

=head1 DESCRIPTION

JSONWire::Client is yet another client library for JSON Wire protocol.

B<THIS IS A DEVELOPMENT RELEASE. API MAY CHANGE WITHOUT NOTICE>.

=head1 METHODS

=over 4

=item my $client = JSONWire::Client->new(%args)

Create new instance of JSONWire::Client with following arguments:

=over 4

=item base: Str(Required)

Base URL like "http://127.0.0.1:9999".

=item agent: LWP::UserAgent(Optional)

=item json: JSON|JSON::XS(Optional)

=back

=item my $session = $client->create_session();

Create new session for JSON Wire Protocol.

=back

=head1 Error Handling

JSONWire::Client throws exception when got a error response from JSON Wire server.

The exception object is L<JSONWire:Client::Exception::HTTP>.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

L<Selenium::Remote::Driver> is great library. But I want to use more simple one.

L<http://code.google.com/p/selenium/wiki/JsonWireProtocol> is official document for JSON Wire Protocol.

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
