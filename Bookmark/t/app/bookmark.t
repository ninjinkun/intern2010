#!perl
use strict;
use warnings;
use Test::More qw/no_plan/;
use HTTP::Status;
use Ridge::Test 'Bookmark';

is get('/bookmark')->code, RC_OK;

1;
