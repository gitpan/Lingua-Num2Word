# For Emacs: -*- mode:cperl; mode:folding -*-
#
# Started by rv@petamem.com at 2002-07-01
#
# $Id: Num2Word.pm,v 1.11 2002/07/16 08:06:42 rv Exp $
#
# PPCG: 0.5

package Lingua::Num2Word;

use strict;

BEGIN {
  use Exporter ();
  use vars qw($VERSION @ISA @EXPORT_OK %MAP %known);
  $VERSION = '0.02';
  @ISA     = qw(Exporter);
  @EXPORT_OK = qw(&cardinal &known_langs &langs);
}

# {{{ %MAP                      language codes from iso639

%MAP = (
	aa => 'aa',	ab => 'ab',	af => 'af',	am => 'am',
	ar => 'ar',	as => 'as',	ay => 'ay',	az => 'az',
	ba => 'ba',	be => 'be',	bg => 'bg',	bh => 'bh',
	bi => 'bi',	bn => 'bn',	bo => 'bo',	br => 'br',
	ca => 'ca',	co => 'co',	cs => 'cs',	cy => 'cy',
	da => 'da',	de => 'de',	dz => 'dz',	el => 'el',
	en => 'en',	eo => 'eo',	es => 'es',	et => 'et',
	eu => 'eu',	fa => 'fa',	fi => 'fi',	fj => 'fj',
	fo => 'fo',	fr => 'fr',	fy => 'fy',	ga => 'ga',
	gd => 'gd',	gl => 'gl',	gn => 'gn',	gu => 'gu',
	ha => 'ha',	he => 'he',	hi => 'hi',	hr => 'hr',
	hu => 'hu',	hy => 'hy',	ia => 'ia',	id => 'id',
	ie => 'ie',	ik => 'ik',	in => 'id',	is => 'is',
	it => 'it',	iw => 'he',	ja => 'ja',	ji => 'yi',
	jw => 'jw',	ka => 'ka',	kk => 'kk',	kl => 'kl',
	km => 'km',	kn => 'kn',	ko => 'ko',	ks => 'ks',
	ku => 'ku',	ky => 'ky',	la => 'la',	ln => 'ln',
	lo => 'lo',	lt => 'lt',	lv => 'lv',	mg => 'mg',
	mi => 'mi',	mk => 'mk',	ml => 'ml',	mn => 'mn',
	mo => 'mo',	mr => 'mr',	ms => 'ms',	mt => 'mt',
	my => 'my',	na => 'na',	ne => 'ne',	nl => 'nl',
	no => 'no',	oc => 'oc',	om => 'om',	or => 'or',
	pa => 'pa',	pl => 'pl',	ps => 'ps',	pt => 'pt',
	qu => 'qu',	rm => 'rm',	rn => 'rn',	ro => 'ro',
	ru => 'ru',	rw => 'rw',	sa => 'sa',	sd => 'sd',
	sg => 'sg',	sh => 'sh',	si => 'si',	sk => 'sk',
	sl => 'sl',	sm => 'sm',	sn => 'sn',	so => 'so',
	sq => 'sq',	sr => 'sr',	ss => 'ss',	st => 'st',
	su => 'su',	sv => 'sv',	sw => 'sw',	ta => 'ta',
	te => 'te',	tg => 'tg',	th => 'th',	ti => 'ti',
	tk => 'tk',	tl => 'tl',	tn => 'tn',	to => 'to',
	tr => 'tr',	ts => 'ts',	tt => 'tt',	tw => 'tw',
	uk => 'uk',	ur => 'ur',	uz => 'uz',	vi => 'vi',
	vo => 'vo',	wo => 'wo',	xh => 'xh',	yi => 'yi',
	yo => 'yo',	zh => 'zh',	zu => 'zu'
       );

# }}}

# {{{ templates for functional and object interface

my $template_func = 'use __PACKAGE_WITH_VERSION__ ();'."\n".
  '$result = __PACKAGE__::__FUNCTION__($number);'."\n";

my $template_obj  = 'use __PACKAGE_WITH_VERSION__ ();'."\n".
  'my $tmp_obj = new __PACKAGE__;'."\n".
  '$result = $tmp_obj->__FUNCTION__($number);'."\n";

# }}}

# {{{ %known                    info about known modules

# Each value is hash with elements:
#  'package'  module name (expected prefix Lingua::$lang::)
#  'version'  module version
#  'function' function name
#  'code'     finction code call template
%known = (
	  af => {
		 'package'  => 'Numbers',
		 'version'  => '0.2',
		 'function' => 'parse',
		 'code'     => $template_obj
		},
	  cs => {
		 'package'  => 'Num2Word',
		 'version'  => '',
		 'function' => 'num2cs_cardinal',
		 'code'     => $template_func
		},
	  de => {
		 'package'  => 'Num2Word',
		 'version'  => '',
		 'function' => 'num2de_cardinal',
		 'code'     => $template_func
		},
	  en => {
		 'package'  => 'Numbers',
		 'version'  => '0.01',
		 'function' => '',
		 'code'     => 'use __PACKAGE_WITH_VERSION__ qw(American);'."\n".
		 'my $tmp_obj = new __PACKAGE__;'."\n".
		 '$tmp_obj->parse($number);'."\n".
		 '$result = $tmp_obj->get_string;'."\n"
		},
	  es => {
		 'package'  => 'Numeros',
		 'version'  => '0.01',
		 'function' => 'cardinal',
		 'code'     => 'use __PACKAGE_WITH_VERSION__ ();'."\n".
		 'my $tmp_obj = new __PACKAGE__;'."\n".
		 '$result = $tmp_obj->__FUNCTION__($number);'."\n"
		},
	  fr => {
		 'package'  => 'Numbers',
		 'version'  => '0.02',
		 'function' => 'number_to_fr',
		 'code'     => $template_func
		},
	  id => {
		 'package'  => 'Nums2Words',
		 'version'  => '0.01',
		 'function' => 'nums2words',
		 'code'     => $template_func
		},
	  ja => {
		 'package'  => 'Number',
		 'version'  => '0.01',
		 'function' => 'to_string',
		 'code'     => 'use __PACKAGE_WITH_VERSION__ ();'."\n".
		 'my @words = __PACKAGE__::__FUNCTION__($number);'."\n".
		 "\$result = join ' ', \@words;"."\n"
		},
	  pt => {
		 'package'  => 'Nums2Words',
		 'version'  => '0.2',
		 'function' => 'nums2words',
		 'code'     => $template_func
		}
	 );

# }}}


# {{{ new                       constructor

sub new {
  my $class = shift;

  return bless {}, $class;
}

# }}}

# {{{ known_langs               list of currently supported languages

sub known_langs {
  my $class = shift;

  return keys %known;
}

# }}}

# {{{ langs                     list of all languages from iso639

sub langs {
  my $class = shift;

  return keys %MAP;
}

# }}}

# {{{ cardinal                 convert number to text

sub cardinal {
  my $self   = ref($_[0]) ? shift() : Lingua::Num2Word->new();
  my $result = '';
  my $lang   = defined $_[0] ? shift : return $result;
  my $number = defined $_[0] ? shift : return $result;

  $lang = lc $lang;

  return $result if ! defined $MAP{$lang};

  if (defined $known{$lang}) {
    # existing language
    my $code = $self->preprocess_code($lang);
    eval $code;
  }

  return $result;
}

# }}}

# {{{ preprocess_code           prepare code for evaluation

sub preprocess_code {
  my $self = shift;
  my $lang = shift;
  my $result = $known{$lang}{code};

  my $pkg_name = 'Lingua::'.uc($lang).'::'.$known{$lang}{package};
  my $pkg_name_with_version = $known{$lang}{version} ne '' ?
    "$pkg_name $known{$lang}{version}" : $pkg_name;
  my $function = $known{$lang}{function};

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

=head2 Language codes and names from iso639

 aa Afar
 ab Abkhazian
 af Afrikaans
 am Amharic

 ar Arabic
 as Assamese
 ay Aymara
 az Azerbaijani

 ba Bashkir
 be Byelorussian
 bg Bulgarian
 bh Bihari

 bi Bislama
 bn Bengali
 bo Tibetan
 br Breton

 ca Catalan
 co Corsican
 cs Czech
 cy Welch

 da Danish
 de German
 dz Bhutani
 el Greek

 en English
 eo Esperanto
 es Spanish
 et Estonian

 eu Basque
 fa Persian
 fi Finnish
 fj Fiji

 fo Faeroese
 fr French
 fy Frisian
 ga Irish

 gd Scots Gaelic
 gl Galician
 gn Guarani
 gu Gujarati

 ha Hausa
 he Hebrew -> SEE IW
 hi Hindi
 hr Croatian
 hu Hungarian

 hy Armenian
 ia Interlingua
 id Indonesian -> SEE IN
 ie Interlingue
 ik Inupiak

 in Indonesian
 is Icelandic
 it Italian
 iw Hebrew

 ja Japanese
 ji Yiddish
 jw Javanese
 ka Georgian

 kk Kazakh
 kl Greenlandic
 km Cambodian
 kn Kannada

 ko Korean
 ks Kashmiri
 ku Kurdish
 ky Kirghiz

 la Latin
 ln Lingala
 lo Laothian
 lt Lithuanian

 lv Latvian, Lettish
 mg Malagasy
 mi Maori
 mk Macedonian

 ml Malayalam
 mn Mongolian
 mo Moldavian
 mr Marathi

 ms Malay
 mt Maltese
 my Burmese
 na Nauru

 ne Nepali
 nl Dutch
 no Norwegian
 oc Occitan

 om (Afan) Oromo
 or Oriya
 pa Punjabi
 pl Polish

 ps Pashto, Pushto
 pt Portuguese
 qu Quechua
 rm Rhaeto-Romance

 rn Kirundi
 ro Romanian
 ru Russian
 rw Kinyarwanda

 sa Sanskrit
 sd Sindhi
 sg Sangro
 sh Serbo-Croatian

 si Singhalese
 sk Slovak
 sl Slovenian
 sm Samoan

 sn Shona
 so Somali
 sq Albanian
 sr Serbian

 ss Siswati
 st Sesotho
 su Sudanese
 sv Swedish

 sw Swahili
 ta Tamil
 te Tegulu
 tg Tajik

 th Thai
 ti Tigrinya
 tk Turkmen
 tl Tagalog

 tn Setswana
 to Tonga
 tr Turkish
 ts Tsonga

 tt Tatar
 tw Twi
 uk Ukrainian
 ur Urdu

 uz Uzbek
 vi Vietnamese
 vo Volapuk
 wo Wolof

 xh Xhosa
 yi Yiddish -> SEE JI
 yo Yoruba
 zh Chinese
 zu Zulu


=head1 EXPORT_OK

=over

=item * cardinal

=item * known_langs

=item * langs

=back

=head1 KNOWN BUGS

None.

=head1 AUTHOR

Roman Vasicek E<lt>rv@petamem.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2002 PetaMem s.r.o.

This package is free software. Tou can redistribute and/or modify it under
the same terms as Perl itself.

=cut

# }}}


