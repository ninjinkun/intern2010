package Bookmark;
use strict;
use warnings;
use base qw/Ridge/;
use Bookmark::MoCo;
__PACKAGE__->configure;

sub user {
    my $self = shift;
    # とりあえずユーザは ninjinkun 決め打ち
    $self->{_user} ||= moco('User')->find(name => 'ninjinkun');
}

1;
