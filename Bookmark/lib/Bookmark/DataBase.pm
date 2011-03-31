package Bookmark::DataBase;
use strict;
use warnings;
use base qw/DBIx::MoCo::DataBase/;

__PACKAGE__->dsn('dbi:mysql:dbname=bookmark_ninjinkun');
__PACKAGE__->username('ninjinkun');
__PACKAGE__->password('ninjinkun');

1;
