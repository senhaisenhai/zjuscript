#Author : shawn
#function: check the eache document whether have abstract or not, print out the result
#
#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;

$xml = new XML::Simple;
$data = $xml->XMLin('Grab.xml');
$noabstractcount=0;
 
  foreach $e (@{$data->{DocSum}})
{
 foreach $a (@{$e->{Item}})
 {
    if ($a->{Name} eq "HasAbstract" )
   {
    if($a->{content}==0)
    {$noabstractcount++;
   print "$e->{Id}",":","HasAbstract",":","$a->{content}","\n";
   }
   }
  }
 }

print "totall number that havs no abstract:","$noabstractcount","\n";
