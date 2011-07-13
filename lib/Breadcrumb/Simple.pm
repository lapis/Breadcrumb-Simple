package Breadcrumb::Simple;
use strict;
use warnings;
use Text::MicroTemplate ();
use Carp ();

our $VERSION = '0.02';

sub new {
    my $class = shift;
    my %args = (
        separator => '>>',
        format    => '<a href="<?=$_{url}?>"><?=$_{title}?></a>',
        @_ .
    );

    $args{data_list} = [];

    bless \%args, $class;
}

sub push {
    my $self = shift;
    my ($data) = @_;

    if ( $data && ref $data && ref $data eq 'ARRAY' ) {
        push @{ $self->{data_list} }, $data;
    }
    else {
        # Exception 
        Carp::croak "Can't use this type.";
    }
}

sub pop {
    my $self = shift;
    return pop @{ $self->{data_list} };
}

sub row {
    my $self = shift;
    return $self->{data_list};
}

sub render {
    my $self = shift;

    my @template;
    my $renderer = Text::MicroTemplate::build_mt($self->{format});
    foreach my $data ( @{ $self->{data_list} } ) {
        push $template, $renderer->(@$data)->as_string;
    }

    return join $self->{separator}, @template;
}

1;
__END__

=head1 NAME

Breadcrumb::Simple - Create breadcrumb list.

=head1 SYNOPSIS

  use Breadcrumb::Simple;

  my $bs   = Breaadcrumb::Simple->new( 
    separator => '->',
    format    => '<a href="<?=$_[0]?>"><?=$_[1]?></a>'
  );
  
  my $bs->push(['url', 'hoghog']);
  my $bs->push(['url2', 'huga']);

  my $html = $bs->render;

=head1 DESCRIPTION

Breadcrumb::Simple is

=head1 METHOD

=head2 $bs->push($arrayref)

=head1 AUTHOR

jiwasaki E<lt>jiwasaki {at} idac.co.jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
