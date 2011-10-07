use strict;
use Test::More tests => 3;
use lib '../lib/';

BEGIN { use_ok 'Breadcrumb::Simple'; }

my $bc = Breadcrumb::Simple->new;
isa_ok $bc, 'Breadcrumb::Simple';

my @method = qw/
    push 
    pop
    row
    clone
    refresh
    render
/;

can_ok $bc, @method;
