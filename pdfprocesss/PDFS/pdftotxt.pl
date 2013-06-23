use strict;

open(MYINPUTFILE, "list.txt"); # open for input
my(@lines) = <MYINPUTFILE>; # read file into list
my @args;
foreach my $line (@lines) # loop thru list
{
     chop($line);
     @args = ("pdftotext", "$line", $line."\.txt");
    system(@args) == 0
    or die "system @args failed: $?";
}
  
close(MYINPUTFILE);
