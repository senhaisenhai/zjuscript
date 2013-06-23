#!/usr/bin/perl -w

use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;
use WWW::Mechanize;
use Time::HiRes;
use Try::Tiny;
use List::MoreUtils qw(uniq);  # List::MoreUtils
 sub findpdf ;
my $start = 'http://pubs.acs.org/userimages/ContentEditor/1219929325129/esthag-masthead.pdf';
# http://onlinelibrary.wiley.com/doi/10.1002/hed.23184/pdf
my @re=findpdf $start;
my $start2=@re[0];
print $start2;
getstore($start2, "testtest");

  
sub findpdf 
{
    @result;
    my $mech = WWW::Mechanize->new(); # need to use WWW::Mechanize;
    if($_[0] =~/acs/)
    {
       return 0;
     }
    $mech->get( $_[0]); #$_[0] is the in put url to analyse$mech->get( $_[0]); #$_[0] is the in put url to analyse
   print "realurl ",$mech->uri(),"\n";
    my $u=$mech->uri();
    $URL=URI->new($u); #need to use URI;
    $b=$URL->scheme."://".$URL->authority; # obtain the url base
    #print "$u current url\n";
    #print "$b current baseurl\n";
    if($mech->uri()=~/\.pdf/)
   {
    push(@result,$mech->uri());
   # return @result;
   }
   else
   {
    my @alllinks=$mech->find_all_links();
    my $wholepdfwrl;
    foreach my $links(@alllinks) #find pdfs in the links
    {
       $alltheurl=$links->url();
       if($alltheurl =~ /pdf/) # matching a pdf file or url
       {
          if($alltheurl =~ /http/)
          {
          $wholepdfwrl=$alltheurl;
          }
          else
          {
          $wholepdfwrl=$b.$alltheurl;
          }        
          push(@result,$wholepdfwrl);
          }
    }
   }
#print "realurlresult ",@result[0],"\n";
    @result; #Return the result array;
} 
    
