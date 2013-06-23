use File::Slurp;

open(MYINPUTFILE, "out.txt"); # open for input
my(@lines) = <MYINPUTFILE>; # read file into list
my @args;
foreach my $line (@lines) # loop thru list
{
      print $lines;
      chop($line);
      my $text = read_file($line) ;
      if($text=~/news/i)
      {
      print $line;
       next;
      }
     @args = ("rm", "$line");
    system(@args) == 0
    or die "system @args failed: $?";
}
  
close(MYINPUTFILE);
