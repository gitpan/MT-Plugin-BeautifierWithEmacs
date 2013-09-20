# MTCodeBeautifier Movable Type Plugin
# Emacs backend

package Voisen::CodeBeautifier;

use MT;
use MT::Template::Context;
use MT::Util qw/decode_html/;
use CGI qw/:standard/;
use Syntax::Highlight::WithEmacs;

our ($EH);

MT::Template::Context->add_container_tag(
    CodeBeautifier => sub {
	&beautifier;
    }
   );

sub highlight {
    my ($string, $mode, @params) = @_;
    $EH ||= Syntax::Highlight::WithEmacs->new(start_server => 0);
    $EH->htmlize_string($string, $mode)->toString
}

sub beautifier {
    my ($ctx, $args, $cond) = @_;
    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');

    my $language = build_expr($ctx, $args->{language}, $cond);

    # This is an unsupported language, so just return the tokens
    highlight($builder->build($ctx, $tokens), $language);
}

# Taken from Brad Choate's MTMacro plug-in
# Allows functionality with that plug-in
sub build_expr {
    my ($ctx, $val, $cond) = @_;
    $val = decode_html($val);
    if (($val =~ m/\<MT.*?\>/) || ($val =~ s/\[(\/?MT(.*?))\]/\<$1\>/g)) {
	my $builder = $ctx->stash('builder');
	my $tok = $builder->compile($ctx, $val);
	defined($val = $builder->build($ctx, $tok, $cond))
	    or return $ctx->error($builder->errstr);
    }
    return $val;
}

1;
