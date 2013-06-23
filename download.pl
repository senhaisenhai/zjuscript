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


 my $mech = WWW::Mechanize::Firefox->new( tab => 'current',);
    $mech->get('http://onlinelibrary.wiley.com/doi/10.1111/j.1365-3016.2012.01259.x/pdf');
 my @alllinks=$mech->find_all_links();
    print $mech->content_type."\n";
 
foreach my $links (@alllinks)
{
print $links,"  \n"
}
    #$mech->save_content('google_com.html', 'google_com files');
    #$mech->save_url( '',"11.pdf" );
