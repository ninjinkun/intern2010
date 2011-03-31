package Bookmark::Engine::Index;
use strict;
use warnings;
use Bookmark::Engine -Base;
use Bookmark::MoCo;

sub default : Public {
    my ($self, $r) = @_;
    # ブックマーク一覧を取得
    my $bookmarks = $r->user->bookmarks;
    # ブックマーク一覧をビューに渡す
    $r->stash->param(
        bookmarks => $bookmarks,
    );
}

1;
