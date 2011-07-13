use strict;
use warnings;
use lib ('../lib');
use Test::More;
use Breadcrumb::Simple;

subtest 'simple using Breadcrumb::Simple' => sub {
    my $bc = Breadcrumb::Simple->new(
        separator => ' -> ',
        format    => '<a href="<?=$_[0]?>"><?=$_[1]?></a>',
    );

    $bc->push( ["hoge", "http://example.com/"] );
    $bc->push( ["huga", "http://example2.com/"] );
    $bc->push( ["piyo", "http://example3.com/"] );

    my $out;
    ok( $out = $bc->render, "successfully rendering." );

    print "$out\n";

    is_deeply(
        $bc->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
            [ "piyo", "http://example3.com/" ]
        ],
        "deeply ok"
    );

    $bc->pop;

    is_deeply(
        $bc->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
        ],
        "pop ok"
    );

};

done_testing;
