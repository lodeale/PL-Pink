package PL::Pink;

use 5.014002;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw( compile compile_from_file); # Estas funciones serán exportadas
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';     # Variable que define la versión del módulo

our %symbol_table;         # La tabla de símbolos $symbol_table{x} contiene
our $data;                 # la información asociada con el objeto 'x'
our $target;               # tipo, dirección, etc.
our @tokens;               # La lista de terminales
our $errorflag;
our ($lookahead, $value);  # Token actual y su atributo
our $tree;                 # referencia al objeto que contiene
our $global_address;       # el árbol sintáctico

# Lexical analyzer 
package Lexical::Analysis;
sub scanner {
}

package Syntax::Analysis;
sub parser {
}

package Machine::Independent::Optimization;
sub Optimize {
}

package Code::Generation;
sub code_generator {
}
   
package Peephole::Optimization;
sub transform {
}


package PL::Tutu;
sub compile {
  my ($input) = @_; # Observe el contexto!
  local %symbol_table = (); 
  local $data = ""; # Contiene todas las cadenas en el programa fuente
  local $target = ""; # target code
  local @tokens =();    # "local" salva el valor que sera recuperado al finalizar
  local $errorflag = 0; # el ámbito
  local ($lookahead, $value) = ();
  local $tree = undef; # Referencia al árbol sintáctico abstracto 
  local $global_address = 0; # Usado para guardar la útima dirección ocupada
  
  ########lexical analysis
  &Lexical::Analysis::scanner($input);

  ########syntax (and semantic) analysis
  $tree = &Syntax::Analysis::parser;

  ########machine independent optimizations
  &Machine::Independent::Optimization::Optimize;

  ########code generation
  &Code::Generation::code_generator;

  ########peephole optimization
  &Peephole::Optimization::transform($target);

  return \$target; #retornamos una referencia a $target
} 

sub compile_from_file {
  my ($input_name, $output_name) = @_; # Nombres de ficheros
  my $fhi;                             # de entrada y de salida
  my $targetref;
  
  if (defined($input_name) and (-r $input_name)) {
    $fhi = IO::File->new("< $input_name");
  }
  else { $fhi = 'STDIN'; }
  my $input;
  { # leer todo el fichero
    local $/ = undef; # localizamos para evitar efectos laterales
    $input = <$fhi>;
  }
  $targetref = compile($input);

  ########code output
  my $fh = defined($output_name)? IO::File->new("> $output_name") : 'STDOUT';
  $fh->print($$targetref);
  $fh->close;
  1; # El último valor evaluado es el valor retornado
}

1;
__END__

=head1 NAME

PL::Pink - Compiler to language Perl

=head1 SYNOPSIS

  use PL::Pink;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for PL::Pink, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

root, E<lt>root@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by root

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
