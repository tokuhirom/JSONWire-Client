#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;
use JSONWire::Client;

# run "phantomjs -webdriver=9999" first.

my $driver = JSONWire::Client->new(
    host => '127.0.0.1',
    port => 9999,
);
my $session = $driver->create_session;
$session->post('/url', {url => 'http://mixi.jp'});
my $data = $session->get('/title');
say $data->{value};
