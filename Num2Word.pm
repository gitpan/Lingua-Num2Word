# For Emacs: -*- mode:cperl; mode:folding -*-
#
# (c) 2002-2004 PetaMem, s.r.o.
#
# PPCG: 0.7

package Lingua::Num2Word;

# {{{ BEGIN
#
BEGIN {
  use Exporter ();
  use vars qw($VERSION $REVISION @ISA @EXPORT_OK %known);
  $VERSION    = '0.05';
  ($REVISION) = '$Revision: 1.18 $' =~ /([\d.]+)/;
  @ISA        = qw(Exporter);
  @EXPORT_OK  = qw(&cardinal &known_langs &langs);
}
# }}}
# {{{ use block
use strict;
use Encode;
# }}}

# {{{ templates for functional and object interface
#
my $template_func = 'use __PACKAGE_WITH_VERSION__ ();'."\n".
                    '$result = __PACKAGE__::__FUNCTION__($number);'."\n";

my $template_obj  = 'use __PACKAGE_WITH_VERSION__ ();'."\n".
                    'my $tmp_obj = new __PACKAGE__;'."\n".
                    '$result = $tmp_obj->__FUNCTION__($number);'."\n";
# }}}
# {{{ %known                    language codes from iso639 mapped to respective interface
#
%known = (aa => undef, ab => undef,
	  af => { 'package'  => 'Numbers',
		  'version'  => '0.2',
                  'charset'  => 'ascii',
		  'function' =>'parse',
	          'code'     => $template_obj },
	  am => undef, ar => undef, as => undef, ay => undef,
	  az => undef, ba => undef, be => undef, bg => undef,
	  bh => undef, bi => undef, bn => undef, bo => undef,
	  br => undef, ca => undef, co => undef,
	  cs => { 'package'  => 'Num2Word',
		  'version'  => '0.01',
                  'charset'  => 'iso-8859-2',
		  'function' =>'num2cs_cardinal',
	          'code'     => $template_func },
	  cy => undef, da => undef,
	  de => { 'package'  => 'Num2Word',
		  'version'  => '0.01',
                  'charset'  => 'iso-8859-1',
		  'function' =>'num2de_cardinal',
	          'code'     => $template_func },
	  dz => undef, el => undef,
	  en => { 'package'  => 'Numbers',
		  'version'  => '0.01',
                  'charset'  => 'ascii',
		  'function' => '',
	          'code'     => 'use __PACKAGE_WITH_VERSION__ qw(American);'."\n".
	  	                'my $tmp_obj = new __PACKAGE__;'."\n".
	  	                '$tmp_obj->parse($number);'."\n".
	  	                '$result = $tmp_obj->get_string;'."\n" },
	  eo => undef,
	  es => { 'package'  => 'Numeros',
		  'version'  => '0.01',
                  'charset'  => 'iso-8859-1',
		  'function' => 'cardinal',
	          'code'     => $template_obj },
	  et => undef,
	  eu => { 'package'  => 'Numbers',
		  'version'  => '0.01',
                  'charset'  => 'iso-8859-1',
		  'function' => 'cardinal2alpha',
	          'code'     => $template_func },
	  fa => undef, fi => undef, fj => undef, fo => undef,
	  fr => { 'package'  => 'Numbers',
		  'version'  => '0.02',
                  'charset'  => 'iso-8859-1',
		  'function' => 'number_to_fr',
	          'code'     => $template_func },
	  fy => undef, ga => undef, gd => undef, gl => undef,
	  gn => undef, gu => undef, ha => undef, he => undef,
	  hi => undef, hr => undef, hu => undef, hy => undef,
	  ia => undef,
	  id => { 'package'  => 'Nums2Words',
		  'version'  => '0.01',
                  'charset'  => 'ascii',
		  'function' => 'nums2words',
	          'code'     => $template_func },
	  ie => undef, ik => undef, is => undef,
	  it => { 'package'  => 'Numbers',
		  'version'  => '0.06',
                  'charset'  => 'iso-8859-1',
		  'function' => 'number_to_it',
	          'code'     => $template_func },
	  ja => { 'package'  => 'Number',
		  'version'  => '0.01',
		  'charset'  => 'ascii',
		  'function' => 'to_string',
		  'code'     => 'use __PACKAGE_WITH_VERSION__ ();'."\n".
 		                'my @words = __PACKAGE__::__FUNCTION__($number);'."\n".
		                "\$result = join ' ', \@words;"."\n" },
	  jw => undef, ka => undef, kk => undef, kl => undef,
          km => undef, kn => undef, ko => undef, ks => undef,
	  ku => undef, ky => undef, la => undef, ln => undef,
	  lo => undef, lt => undef, lv => undef, mg => undef,
	  mi => undef, mk => undef, ml => undef, mn => undef,
	  mo => undef, mr => undef, ms => undef, mt => undef,
	  my => undef, na => undef, ne => undef,
	  nl => { 'package'  => 'Numbers',
		  'version'  => '1.2',
                  'charset'  => 'ascii',
	  	  'function' => 'parse',
 	          'code'     => $template_obj },
	  no => undef, oc => undef, om => undef, or => undef,
	  pa => undef,
	  pl => { 'package'  => 'Numbers',
		  'version'  => '1.0',
                  'charset'  => 'cp1250',
		  'function' => 'parse',
	          'code'     => $template_obj },
	  ps => undef,
	  pt => { 'package'  => 'Nums2Words',
		  'version'  => '1.03',
                  'charset'  => 'iso-8859-1',
		  'function' => 'num2word',
	          'code'     => $template_func },
	  qu => undef, rm => undef, rn => undef, ro => undef,
	  ru => { 'package'  => 'Number',
		  'version'  => '0.03',
                  'charset'  => 'windows-1251',
		  'function' => 'rur_in_words',
	          'code'     => 'use __PACKAGE_WITH_VERSION__ ();'."\n".
		                '$result = __PACKAGE__::__FUNCTION__($number);'."\n".
		                '$result =~ s/\S+\s+\S+\s+\S+$// if ($result);' },
	  rw => undef, sa => undef, sd => undef, sg => undef,
	  sh => undef, si => undef, sk => undef, sl => undef,
	  sm => undef, sn => undef, so => undef, sq => undef,
	  sr => undef, ss => undef, st => undef, su => undef,
          sv => { 'package'  => 'Num2Word',
		  'version'  => '0.04',
                  'charset'  => 'iso-8859-1',
		  'function' => 'num2sv_cardinal',
		  'code'     => $template_func },
	  sw => undef, ta => undef, te => undef, tg => undef,
	  th => undef, ti => undef, tk => undef, tl => undef,
	  tn => undef, to => undef, tr => undef, ts => undef,
          tt => undef, tw => undef, uk => undef, ur => undef,
	  uz => undef, vi => undef, vo => undef, wo => undef,
	  xh => undef, yi => undef, yo => undef,
          zh => { 'package'  => 'Numbers',
                  'version'  => '0.03',
                  'charset'  => 'utf8',
                  'function' => '',
                  'code'     => 'use __PACKAGE_WITH_VERSION__ qw(traditional);'."\n".
                                'my $tmp_obj = new __PACKAGE__;'."\n".
                                '$tmp_obj->parse($number);'."\n".
                                '$result = $tmp_obj->get_string;'."\n" },
	  zu => undef );
# }}}
# {{{ %known duplicity          codes from iso639 have the same interface of another code
#
  $known{in} = defined $known{id} ? {%{$known{id}}, lang=>'id'} : $known{id};
  $known{iw} = defined $known{he} ? {%{$known{he}}, lang=>'he'} : $known{he};
  $known{ji} = defined $known{yi} ? {%{$known{yi}}, lang=>'yi'} : $known{yi};
# }}}
# {{{ new                       constructor
#
sub new {
  return bless {}, shift;
}
# }}}
# {{{ known_langs               list of currently supported languages
#
sub known_langs {
  my @result;

  for (keys %known) {
    push @result,$_ if (defined $known{$_});
  }

  return @result if (wantarray);
  return \@result;
}
# }}}
# {{{ langs                     list of all languages from iso639
#
sub langs {
  my @tmp = keys %known;
  return @tmp if (wantarray);
  return \@tmp;
}
# }}}
# {{{ cardinal                  convert number to text
#
sub cardinal {
  my $self   = ref($_[0]) ? shift : Lingua::Num2Word->new();
  my $result = '';
  my $lang   = defined $_[0] ? shift : return $result;
  my $number = defined $_[0] ? shift : return $result;

  $lang = lc $lang;

  return $result if (!defined $known{$lang} || !$known{$lang}{charset});

  if (defined $known{$lang}{lang}) {
    eval $self->preprocess_code($known{$lang}{lang});
  } else {
    eval $self->preprocess_code($lang);
  }

  if ($result && $known{$lang}{charset} ne "utf8") {
    $result = Encode::decode($known{$lang}{charset},$result);
  }

  return $result;
}
# }}}
# {{{ preprocess_code           prepare code for evaluation
#
sub preprocess_code {
  my $self                  = shift;
  my $lang                  = shift;
  my $result                = $known{$lang}{code};
  my $pkg_name              = 'Lingua::'.uc($lang).'::'.$known{$lang}{package};
  my $pkg_name_with_version = $known{$lang}{version} ne ''
                            ? "$pkg_name $known{$lang}{version}" : $pkg_name;
  my $function              = $known{$lang}{function};

  $result =~ s/__PACKAGE_WITH_VERSION__/$pkg_name_with_version/g;
  $result =~ s/__PACKAGE__/$pkg_name/g;
  $result =~ s/__FUNCTION__/$function/g;

  return $result;
}
# }}}

1;
__END__

# {{{ module documentation

=head1 NAME

Lingua::Num2Word - wrapper for number to text conversion modules of
various languages in the Lingua:: hierarchy.

=head1 SYNOPSIS

 use Lingua::Num2Word;

 my $numbers = Lingua::Num2Word->new;

 # try to use czech module (Lingua::CS::Num2Word) for conversion to text
 my $text = $numbers->cardinal( 'cs', 123 );

 # or procedural usage if you dislike OO
 my $text = Lingua::Num2Word::cardinal( 'cs', 123 );

 print $text || "sorry, can't convert this number into czech language.";

=head1 DESCRIPTION

Lingua::Num2Word is module for converting numbers into their representation
in spoken language. This is wrapper for various Lingua::XX::Num2Word modules.
Output encoding is utf8.

For further information about various limitations see documentation for
currently used package.

=head2 Functions

=over

=item * known_langs

List of all currently supported languages.

=item * langs

List of all known language codes from iso639.

=item * cardinal(lang,number)

Conversion from number to text representation in specified language.

=back

=head2 Language codes and names from iso639 can be found at L<"http://www.triacom.com/archive/iso639.en.html">

=head1 EXPORT_OK

=over

=item * cardinal

=item * known_langs

=item * langs

=back

=head2 Required modules / supported languages

This module is only wrapper and require other cpan modules for requested
conversions eg. Lingua::AF::Numbers for Afrikaans.

Currently supported languages/modules are:

=over

=item * af - Lingua::AF::Numbers

=item * cs - Lingua::CS::Num2Word

=item * de - Lingua::DE::Num2Word

=item * en - Lingua::EN::Numbers

=item * es - Lingua::ES::Numeros

=item * eu - Lingua::EU::Numbers

=item * fr - Lingua::FR::Numbers

=item * id - Lingua::ID::Nums2Words

=item * in - see 'id'

=item * it - Lingua::IT::Numbers

=item * ja - Lingua::JA::Number

=item * nl - Lingua::NL::Numbers

=item * pl - Lingua::PL::Numbers

=item * pt - Lingua::PT::Nums2Words

=item * ru - Lingua::RU::Number

=item * sv - Lingua::SV::Num2Word

=item * zh - Lingua::ZH::Numbers

=back

=head1 KNOWN BUGS

None.

=head1 AUTHOR

Roman Vasicek E<lt>rv@petamem.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2002-2004 PetaMem s.r.o.

This package is free software. You can redistribute and/or modify it under
the same terms as Perl itself.

=cut

# }}}
