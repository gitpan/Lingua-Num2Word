
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Lingua::Num2Word is a wrapper for modules for converting numbers into their equivalent in written representation.",
  "AUTHOR" => "PetaMem s.r.o. <info\@petamem.com>",
  "BUILD_REQUIRES" => {
    "Data::Dumper" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Lingua-Num2Word",
  "EXE_FILES" => [],
  "LICENSE" => "open_source",
  "NAME" => "Lingua::Num2Word",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Encode" => 0,
    "Exporter" => 0,
    "Lingua::AFR::Numbers" => 0,
    "Lingua::CES::Num2Word" => 0,
    "Lingua::DEU::Num2Word" => 0,
    "Lingua::ENG::Numbers" => 0,
    "Lingua::EUS::Numbers" => 0,
    "Lingua::FRA::Nums2Words" => 0,
    "Lingua::IND::Nums2Words" => 0,
    "Lingua::ITA::Numbers" => 0,
    "Lingua::JPN::Number" => 0,
    "Lingua::NLD::Numbers" => 0,
    "Lingua::NOR::Num2Word" => 0,
    "Lingua::POL::Numbers" => 0,
    "Lingua::POR::Nums2Words" => 0,
    "Lingua::RUS::Number" => 0,
    "Lingua::SPA::Numeros" => 0,
    "Lingua::SWE::Num2Word" => 0,
    "Lingua::ZHO::Numbers" => 0,
    "strict" => 0,
    "utf8" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.0477",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



