use strict;
use warnings;
use lib ('../lib');
use Test::More;
use Test::Exception;
use Breadcrumb::Simple;

subtest 'exception' => sub {
    my $bc = Breadcrumb::Simple->new(
        separator => ' -> ',
        format    => '<a href="<?=$_[1]?>"><?=$_[0]?></a>',
    );

    dies_ok { $bc->push(111) }      "not an Array 1";
    dies_ok { $bc->push("aaa") }    "not an Array 2";
};

done_testing;
