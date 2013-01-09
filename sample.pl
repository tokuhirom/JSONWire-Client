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
my $title = $session->get('/title');
say $title;

$session->post('/url', {url => 'http://64p.org/'});
{
    my $data = $session->post('/elements', {using => 'css selector', value => '.sites .title'});
    for my $id (map { $_->{ELEMENT} } @{$data}) {
        my $dat = $session->get("/element/$id/text");
        say $dat;
    }
}
