package Bookmark::Engine::Bookmark;
use strict;
use warnings;
use HTTP::Status;
use Bookmark::Engine -Base;
use Bookmark::MoCo;

sub default : Public {
    my ($self, $r) = @_;
    my $bookmark = moco('Bookmark')->retrieve($r->req->uri->param('id') || $r->req->param('id'))
        or Ridge::Exception::RequestError->throw(code => RC_NOT_FOUND);

    $r->stash->param(
        bookmark => $bookmark
    );
}

sub delete : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _delete_post {
    my ($self, $r) = @_;
    $r->user->delete_bookmark($r->req->param('entry_id'))
        or Ridge::Exception::RequestError->throw(code => RC_NOT_FOUND);
    $r->res->redirect('/');
}

sub add : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _add_get {
}

sub _add_post {
    my ($self, $r) = @_;

    $r->req->form(
        url => [ 'NOT_BLANK', 'HTTP_URL' ],
    );

    if (not $r->req->form->has_error) {
        my $bookmark = $r->user->add_bookmark(
            url     => $r->req->param('url'),
            comment => $r->req->param('comment'),
        );
        $r->res->redirect('/bookmark?id=' . $bookmark->id);
    }
}

1;
