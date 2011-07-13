package Breadcrumb::Simple;
use strict;
use warnings;
use Text::MicroTemplate ();
use Carp                ();

our $VERSION = '0.10';

sub new {
    my $class = shift;
    my %args  = (
        separator => '>>',
        format    => '<a href="<?=$_[0]?>"><?=$_[1]?></a>',
        @_
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

sub clone {
    my $self      = shift;
    my $new_crumb = Breadcrumb::Simple->new(
        separator => $self->{separator},
        format    => $self->{format}
    );

    foreach my $data ( @{ $self->{data_list} } ) {
        $new_crumb->push($data);
    }

    return $new_crumb;
}

sub refresh {
    my $self = shift;
    $self->{data_list} = [];
}

sub render {
    my $self = shift;
    my %args = @_;

    my $format    = $args{format}    ? $args{format}    : $self->{format};
    my $separator = $args{separator} ? $args{separator} : $self->{separator};

    my @template = ();
    my $renderer = Text::MicroTemplate::build_mt($format);
    foreach my $data ( @{ $self->{data_list} } ) {
        CORE::push @template, $renderer->(@$data)->as_string;
    }

    return join $separator, @template;
}
1;

__END__

=head1 NAME

Breadcrumb::Simple - Create a simple breadcrumb.

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

Breadcrumb::Simple is simple breadcrumb create module.

=head1 METHOD

=head2 $bs->new(%args)

initialize Breadcrumb::Simple object.
optional parameter is format and separator.
format detail is L<Text::MicroTemplate> syntax.

=head2 $bs->push($arrayref)

push to data lists.
please specify the param specified by the format.

=head2 $bs->pop

pop from data lists.

=head2 $bs->row

get the row. return arrayref(data lists).

=head2 $bs->clone

clone the this object. return new Breadcrumb::Simple.

=head2 $bs->refresh

refresh data lists.

=head2 $bs->render(%args)

returns a html of the combined list.
optional parametor is format and separator.

=head1 AUTHOR

Iwasaki Junichi E<lt>lapis0896 {at} gmail.comE<gt>

=head1 SEE ALSO

L<Text::MicroTemplate>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
