#!/opt/local/bin/perl
use strict;
use warnings;

use FindBin;
use Path::Class;
use lib 'lib';
use lib glob 'modules/*/lib';

use Getopt::Long;
use Pod::Usage;

use Ridge::Daemon;

my $help    = 0;
my $port    = 3000;
my $fast    = 0;
my $verbose = 0;
my $env;
my $reboot;
my $reboot_port;

GetOptions(
    'help|?'    => \$help,
    'port|p=s'  => \$port,
    'fast|f'    => \$fast,
    'env|e=s'   => \$env,
    'verbose|v' => \$verbose,
    'reboot|r'  => \$reboot,
    'reboot_port|rp=s' => \$reboot_port,
);

pod2usage(1) if $help;

local $ENV{RIDGE_ENV} = $env if $env;

Ridge::Daemon->run('Bookmark', {
    root             => dir($FindBin::Bin)->parent,
    port             => $port,
    fast             => $fast,
    verbose          => $verbose,
    reboot_on_reload => $reboot,
    reboot_port      => $reboot_port,
});

1;

=head1 NAME

server.pl - Ridge Server

=head1 SYNOPSIS

server.pl [options]

 Options:
   -?  --help               display this help and exits
   -p  --port=<port>        port (defaults to 3000)
   -f  --fast               fast mode with disabling some features.
   -v  --verbose            verbose mode (display serve_static() results).
   -e  --env=<variable>     define $ENV{RIDGE_ENV}
   -r  --reboot             reboot on modules changes instead of refresh.
   -rp --reboot_port=<port> binding reboot server to the port.

=head1 DESCRIPTION

Run a Ridge server for this application.

=head1 AUTHOR

Naoya Ito, "naoya@hatena.ne.jp"

=cut
