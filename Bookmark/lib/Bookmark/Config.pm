package Bookmark::Config;
use strict;
use warnings;
use base qw/Ridge::Config/;
use Path::Class qw/file/;

my $root = file(__FILE__)->dir->parent->parent->parent;

__PACKAGE__->instance(__PACKAGE__->setup({
    root          => __PACKAGE__->find_root,
    namespace     => 'Bookmark',
    charset       => 'utf-8',
    ignore_config => 1,
    static_path   => [
        '^/images\/',
        '^/js\/',
        '^/css\/',
        '^/favicon\.ico',
    ],
    URI => {
        use_lite => 1,
        filter   => \&uri_filter,
    },

    ## Application specific configuration
    app_config => {
        default => {
            uri => URI->new('http://local.hatena.ne.jp:3000/'),
        },
    }
}));

sub uri_filter {
    my $uri = shift;
    my $path = $uri->path;
    if ($path =~ m{^/bookmark/(\d+)$}) {
        $uri->path('/bookmark');
        $uri->param(id => $1);
    }
    $uri;
}

1;
