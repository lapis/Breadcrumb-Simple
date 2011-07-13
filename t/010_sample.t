use strict;
use warnings;
use lib ('../lib');
use Test::More;
use Breadcrumb::Simple;

subtest 'How to use Breadcrumb::Simple' => sub {
    # simple use
    my $bc = Breadcrumb::Simple->new(
        separator => ' -> ',
        format    => '<a href="<?=$_[1]?>"><?=$_[0]?></a>',
    );
 
    $bc->push( ["hoge", "http://example.com/"] );
    $bc->push( ["huga", "http://example2.com/"] );
    $bc->push( ["piyo", "http://example3.com/"] );

    my $out;
    ok( $out = $bc->render, "successfully rendering." );

    print "$out\n";

    # row check
    is_deeply(
        $bc->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
            [ "piyo", "http://example3.com/" ]
        ],
        "deeply ok"
    );

    # pop check
    $bc->pop;
    is_deeply(
        $bc->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
        ],
        "pop ok"
    );

    # push check
    $bc->push(["nya", "http://example.com/nya/" ]);
    is_deeply(
        $bc->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
            [ "nya" , "http://example.com/nya/" ],
        ],
        "push ok"
    );

    # clone check
    my $clone = $bc->clone;
    $bc->pop;
    is_deeply(
        $clone->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
            [ "nya" , "http://example.com/nya/" ],
        ], 
        "clone ok"
    );
    
    # substitution check
    my $equal = $bc;
    $bc->push(["neko", "http://example.com/neko/"]);
    is_deeply(
        $equal->row,
        [
            [ "hoge", "http://example.com/"  ],
            [ "huga", "http://example2.com/" ],
            [ "neko" , "http://example.com/neko/" ],
        ], 
        "equal ok"
    );   

    # refresh check
    $bc->refresh;
    is_deeply( $bc->row, [], "Breadcrumb::Simple object is empty");

};

done_testing;
