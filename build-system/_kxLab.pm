
use strict;
use warnings FATAL => 'all';

package _kxLab;

sub error
{
  my $message = shift;
  my $func = shift;

  print STDERR "Error: $message\n";
  if( defined( $func ) )
  {
    &$func();
  }
  exit 1;
}

sub command_error
{
  my $command = shift;
  my $context = shift;

  error( "$command failed at @{$context}[1] line @{$context}[2]" );
}

sub system
{
  my $command = shift;

  if( system( $command ) )
  {
    my @context = caller;
    command_error($command, \@context);
  }
}

1;
