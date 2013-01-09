use strict;
use Test::More;

use_ok $_ for qw(
    JSONWire::Client
    JSONWire::Client::Exception::HTTP
    JSONWire::Client::Session
);

done_testing;
