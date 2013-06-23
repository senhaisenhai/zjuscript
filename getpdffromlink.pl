#Author : shawn
#function: check the eache document whether have abstract or not, print out the result
#
#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;
use WWW::Mechanize;
use Time::HiRes;
use Try::Tiny;
use List::MoreUtils qw(uniq);  # List::MoreUtils

sub findpdf ;

$xml = new XML::Simple;
$data = $xml->XMLin('findlink.xml');
@wholeurl;
$count_total=0;
$count_processing=0;
   foreach $e (@{$data->{LinkSet}->{IdUrlList}->{IdUrlSet}})
   {
      $count_total++; # count the totall number of links that related 
   }
   foreach $e (@{$data->{LinkSet}->{IdUrlList}->{IdUrlSet}})
   {
      $e->{Id};
      $count_processing++;
        my $random_number = rand(1);
        Time::HiRes::sleep($random_number);  # use Time::HiRes qw(usleep nanosleep); never flood the web
       if(ref($e->{ObjUrl}) eq 'ARRAY') #some have more than one link to the destination pdfs so we need to choose one link I choose fist one;
      {
         if ($e->{ObjUrl}[0]->{Url})
         {
          if( ($e->{ObjUrl}[0]->{Provider}->{Name} =~ /Informa Healthcare/)|| #stop list for these now welcomed database !!!!!!!!!!!! very important
              ($e->{ObjUrl}[0]->{Provider}->{Name} =~ /American Chemical Society/)||
              ($e->{ObjUrl}[0]->{Provider}->{Name} =~ /Mary Ann Liebert/)
            )
               
          {
           next;
            }
          my $inurl=$e->{ObjUrl}[0]->{Url};
            try{
                  # print $e->{ObjUrl}[0]->{Provider}->{Name};
                   my @backurlforthis = findpdf($inurl,$e->{Id});
                   @backurlforthis=uniq(@backurlforthis);
                   @wholeurl=join(@wholeurl,@backurlforthis);
                   @wholeurl=uniq(@backurlforthis); # filter the dumplicate item
                   print "+++++++++++++$count_processing|$count_total+++++++++++++\n";
                } 
            catch 
                {
                   print "caught error: $_";
                 };
          }
      }
      else
      {
         $e->{Id};
         if ($e->{ObjUrl}->{Url})
         {
            if( ($e->{ObjUrl}->{Provider}->{Name} =~ /Informa Healthcare/)||  #stop list for these now welcomed database !!!!!!!!!!!! very important
                ($e->{ObjUrl}->{Provider}->{Name} =~ /American Chemical Society/)||
                ($e->{ObjUrl}->{Provider}->{Name} =~ /Mary Ann Liebert/)
              )
          {
           next;
            }
            my $inurl=$e->{ObjUrl}->{Url};
            try{
                  print $e->{ObjUrl}->{Provider}->{Name};
                   my @backurlforthis = findpdf($inurl,$e->{Id});
                   @backurlforthis=uniq(@backurlforthis);      
                   @wholeurl=join(@wholeurl,@backurlforthis);
                   @wholeurl=uniq(@backurlforthis);    
                   print "-------------$count_processing|$count_total-------------\n";                  
                } 
            catch 
                {
                 print "caught error: $_";
                };
 
         }
       }  
    }
    
 foreach my $whole(@wholeurl)
{
  print "$whole \n";
}
    
    
open my $fh, '>', "output.txt" or die "Cannot open output.txt: $!";
# Loop over the url array
foreach (@wholeurl)
{
    print $fh "$_\n"; # Print each entry in our array to the file
}
close $fh; # Not necessary, but nice to do
print "result write to output.txt\n"; 
 
     
#the function find the links that may contain the pdf file
  
sub findpdf 
{
    @result;
    my $mech = WWW::Mechanize->new(); # need to use WWW::Mechanize;
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
    return @result;
   }
   else
   {
    my @alllinks=$mech->find_all_links();
    my $wholepdfwrl;
    foreach my $links(@alllinks) #find pdfs in the links
    {
       $alltheurl=$links->url();
       print "this is all the url",$alltheurl,"\n";
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

          $wholepdfwrl=$_[1].' '.$wholepdfwrl;
          push(@result,$wholepdfwrl);
          }
    }
   }
#print "realurlresult ",@result[0],"\n";
    @result; #Return the result array;
} 

 
#print Dumper($data);
#print "totall number that havs no abstract:","$noabstractcount","\n";
