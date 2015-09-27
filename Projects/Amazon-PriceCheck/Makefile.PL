use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Amazon::PriceCheck',
    VERSION_FROM      => 'lib/Amazon/PriceCheck.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Amazon/PriceCheck.pm', # retrieve abstract from module
       AUTHOR         => 'A. U. Thor <wdr1@localdomain>') : ()),
);
