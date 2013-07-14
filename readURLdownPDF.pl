use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;
use WWW::Mechanize;
use Time::HiRes;
use Try::Tiny;
use List::MoreUtils qw(uniq);  # List::MoreUtils
use WWW::Mechanize::Firefox;
use strict;

open(MYINPUTFILE, "output.txt"); # open for input
my(@lines) = <MYINPUTFILE>; # read file into list
@lines=uniq(@lines);
my $count=0;
my $supertime=0;
my $id;
my $pdfurl;
foreach my $line (@lines) # loop thru list
{
  #my $radon=rand(130);
 # print $radon,"\n";
  #Time::HiRes::sleep($radon+$supertime);
  $count++;
  $id=substr $line,0,8;
  $pdfurl=substr $line,9;
  print $id.' '.$pdfurl."\n";
 
   if ($count<34)
    {
    next;
    }
    if($pdfurl=~/wiley/)
   {
    #my $mech = WWW::Mechanize::Firefox->new( tab => 'current',);
   # $mech->get($pdfurl);
    next;
   }
  
   if($pdfurl=~/expert/)
   {
    next;
    }
  

 #  if ($count<105) #start
   #{
   # next;
    #}
  try{

   my $mech = WWW::Mechanize->new();
    
   $mech->get($pdfurl);
 
    if($mech->ct()=~/pdf/) #if it is a pdf link
   {

    #$mech->save_url($pdfurl, $id."_".$count."\.pdf");
    getstore($pdfurl, $id."_".$count."\.pdf"); downloadthis file
    print "pdf"."\n";
     }

    if($mech->ct()=~/html/) #if it is not a pdf
    {
     
      if ($pdfurl=~/\+html/) #some have a +html sufix need to remove it
      {
        my($first, $rest)=split(/\+/,$pdfurl,2);
        try{
       # $mech->save_url($first, $id."_".$count."\.pdf")
        getstore($first, $id."_".$count."\.pdf");
           } #downloadthis file
        catch{print "download problems: @_ "."\n";}
        }
     print "html"."\n";
    }
     
     }
  catch{
   # $supertime+=60;
     print "problems @_";
   } 
   finally {
    if (@_) {
      print "The download block died with: @_\n";
    } else {
      print "downlad successful ",$count,"\n";
     # $supertime=0;
    }
  }
    #print "supertime:",$supertime,"\n","\n";
   

 # print $count,"$line"; # print in sort order
 }

  
close(MYINPUTFILE);
