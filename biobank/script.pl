#!/usr/bin/perl -w
use strict;

my @a = (1, 2, 3); # The array we want to save

# Open a file named "output.txt"; die if there's an error
open my $fh, '>', "output.txt" or die "Cannot open output.txt: $!";

# Loop over the array
foreach (@a)
{
    print $fh "$_\n"; # Print each entry in our array to the file
}
close $fh; # Not necessary, but nice to do