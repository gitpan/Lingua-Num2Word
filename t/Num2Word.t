#!/usr/bin/perl
# For Emacs: -*- mode:cperl; mode:folding -*-
#
# Copyright (C) PetaMem, s.r.o. 2009-present
#

# {{{ use block

use strict;
use warnings;
use utf8;
use 5.10.1;

use Data::Dumper;
use Test::More;

# }}}
# {{{ variable declarations

my $tests;
my $known_langs = [qw(afr ces deu eng eus fra ind ita jpn
                      nld nor pol por rus spa swe zho)];

my $es          = q{};

# }}}
# {{{ basic tests

BEGIN {
    use_ok('Lingua::Num2Word');
}

$tests++;

use Lingua::Num2Word     qw(preprocess_code
                            known_langs
                            get_interval
                            cardinal);

# }}}

# {{{ preprocess_code

my $o   = Lingua::Num2Word->new;

my $got = Lingua::Num2Word::preprocess_code($o, 'ces');
my $exp = q{ use Lingua::CES::Num2Word ();$result = Lingua::CES::Num2Word::num2ces_cardinal($number);};
$got =~ s{\n|\s{2,}}{}xmsg;
is($got, $exp, 'prepare code for Czech');
$tests++;

$got = Lingua::Num2Word::preprocess_code($o, 'xx');
$exp = undef;
is($got, $exp, 'prepare code for nonexisting language');
$tests++;

$got = Lingua::Num2Word::preprocess_code(undef, 'ces');
$exp = q{ use Lingua::CES::Num2Word ();
                       $result = Lingua::CES::Num2Word::num2ces_cardinal($number);
                     };

is($got, $exp, 'prepare code for Czech 2');
$tests++;

$got = Lingua::Num2Word::preprocess_code(undef, 'zho');
$exp =q{ use Lingua::ZHO::Numbers qw(traditional);
                       my $tmp_obj = new Lingua::ZHO::Numbers;
                       $tmp_obj->parse($number);
                       $result = $tmp_obj->get_string;
                     };
is($got, $exp, 'prepare code for Chinese');
$tests++;

$got = Lingua::Num2Word::preprocess_code();
$exp = undef;
is($got, $exp, 'undef args');
$tests++;

# }}}
# {{{ known_langs

$got = known_langs();
is_deeply($got, $known_langs, 'known langs, scalar context');
$tests++;

my @bak = known_langs();
is_deeply(\@bak, $known_langs, 'known langs, list context');
$tests++;

# }}}
# {{{ get_interval

$got = get_interval('ces');
$exp = [0, 999_999_999];
is_deeply($got, $exp, 'Czech -> got interval');
$tests++;

$got = get_interval('xx');
$exp = undef;
is($got, $exp, 'Nonexisting language -> got undef');
$tests++;

$got = get_interval();
$exp = undef;
is($got, $exp, 'undef args');
$tests++;

# }}}
# {{{ cardinal

$got = cardinal('ces', 708);
$exp = 'sedm set osm';
is($got, $exp, '708 in Czech');
$tests++;

$got = cardinal('ces');
$exp = $es;
is($got, $exp, 'undef in Czech');
$tests++;

$got = cardinal(undef, 708);
$exp = $es;
is($got, $exp, '708 in undef language');
$tests++;

$got = cardinal();
$exp = $es;
is($got, $exp, 'undef args');
$tests++;

$got = cardinal('ces', -2);
$exp = $es;
is($got, $exp, 'out of range');
$tests++;

# }}}

done_testing($tests);

__END__
