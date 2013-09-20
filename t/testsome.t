use strict;
use warnings;
use Test::More;

use lib $ENV{MT_HOME} ? "$ENV{MT_HOME}/lib" : '.';

BEGIN {
    eval "use MT; 1" or
	plan skip_all => 'No Movable Type found, cannot test';
}

plan tests => 1;

use if $MT::VERSION > 3, 'MT::Compat::v3';
require "MT/Plugin/BeautifierWithEmacs/beautifier.pl";
like(Voisen::CodeBeautifier::highlight(q((when "string" :tag)), 'el'),
     qr,^<pre>\(<font color="#[[:xdigit:]]{6}">when</font> <font color="#[[:xdigit:]]{6}">"string"</font> <font color="#[[:xdigit:]]{6}">:tag</font>\)</pre>$,);
