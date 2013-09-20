# PODNAME: MT::Plugin::BeautifierWithEmacs

=encoding utf8

=head1 NAME

MT::Plugin::BeautifierWithEmacs - plug-in for Movable Type to use Syntax::Highlight::WithEmacs

=head1 VERSION

version 0.1

=head1 DESCRIPTION

due to this module being a L<MT|http://movabletype.org/> plug-in, its
installation is a bit different. You need to copy the directory
C<MT/Plugin/BeautifierWithEmacs> into your C<$MT_HOME/plugins>
directory (ex. C</var/www/lib/mt5/plugins>)

MT will then autoload it on the next FCGI/Webserver restart

=head1 USAGE

the plug-in is modeled after the (now defunct) MTCodeBeautifier
plug-in. To use it in a template, the code is:

    <MTCodeBeautifier language="pl">
      my $x = 42;
    </MTCodeBeautifier>

To use it inside of posts, you need the
L<MTMacro|http://www.bradchoate.com/past/mtmacros.php> plug-in.

Quoting the original docs:

``After installing MTMacro, surround your C<E<lt>MTEntryBodyE<gt>> tags in your
Movable Type templates with C<E<lt>MTMacroApplyE<gt>E<lt>/MTMacroApplyE<gt>>. Place the
following macro definition somewhere in each of the templates you want
to use MTCodeBeautifier on your posts:

    <MTMacroDefine name="beautifier" ctag="code">
     <MTCodeBeautifier language="[MTMacroAttr name='language']">
      <MTMacroContent>
     </MTCodeBeautifier>
    </MTMacroDefine>

Then, in your posts, surround your code with

    <code language="my-language"></code>

"my-language" is passed on as the I<$mode> parameter to
L<Syntax::Highlight::WithEmacs>, so it should be a file extension
registered with Emacs, such as "pl".  Note: you don't have to use this
macro. It's just a suggestion.´´

=head1 TEXTILE2

to use this plug-in with MT-Textile (original site defunct, now
bundled with MT), you have to modify C<textile2.pl> yourself, I'm
sorry! a unified diff file that you can apply with C<patch> is
included in this module's installation directory.

The gist for manual modification: Replace all the if/elsif statements
and manual calls to
C<Voisen::CodeBeautifier::highlight_(somelanguage)> with one single
call to

    $code = Voisen::CodeBeautifier::highlight($code, $lang) if $lang;

and save the file.

=head1 AUTHOR

Ailin Nemui E<lt>ailin at devio dot usE<gt>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ailin Nemui.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or (at
your option) any later version.

=cut
