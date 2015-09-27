#!/usr/bin/perl -w

## slashsig.pl
## 
## Script to automatically update one's slashdot sig.
## 
## Created 12/7/02 -- William Reardon <wdr1@pobox.com>
## 
## $Id: slashsig.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $
## 

use strict;
use Getopt::Long;
use LWP::UserAgent;
use HTTP::Cookies;
use Data::Dumper;
use URI::Escape;

our $VERSION = '$Revision: 1.1.1.1 $ ';
our $_DEBUG_LEVEL = 0;
our $_AGENT_SPOOF = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2b) Gecko/20021016';
our $_MAX_SIG_SIZE = 120; # this could be a problem with the "star"

&main();

sub main {
  my $cfg = &init();
  &slash_login($cfg);
  &{ $cfg->{sigfunc} }( $cfg );
  &update_sig( $cfg );
}


#############################################################  update_sig  ###
## Update the signature.
sub update_sig {
  my ($cfg) = @_;

  ## If you've gone through the trouble to look at the source code
  ## to figure out how to disable the asterik, you must really care.
  ## If you really care, just throw '--no-star' on the command line.
  ## That will eliminate it, but also leave you easy to upgrade to
  ## new versions of slashsig.  Fair?
  unless ($cfg->{'no-star'}) {
    $cfg->{sigtext} =
      '<A HREF=http://wdr1.com/s>*</A> ' .
        $cfg->{sigtext};
  }
  debug("Setting sigtext to '", $cfg->{sigtext}, "'...");

  ## Get the "prompt" page & extract data from it
  my $url = "$cfg->{baseurl}/users.pl?op=edituser";
  my $ua = LWP::UserAgent->new;
  $ua->agent( $_AGENT_SPOOF );
  my $req = HTTP::Request->new(GET => $url);
  my $cjar = $cfg->{cookies};
  $cjar->add_cookie_header( $req );
  my $res = $ua->request( $req );
  unless ($res->is_success) {
    print "HTTP Error getting form key: " . $res->status_line . "\n";
    exit(1);
  }
  my $html = $res->as_string;

  ## Extract the bits
  my %data;
  foreach my $i (qw|formkey formname homepage name realemail realname aim icq yahoo jabber calendar_url|) {
    ($data{$i}) =
      $html =~ /<input TYPE="(?:HIDDEN|TEXT)"[^>]+NAME="$i"[^>]+VALUE="([^"]+)[^>]*>/si;
  }

  ($data{bio}) = $html =~ /<textarea name="bio"[^>]+>([^<]+)<\/text/si;
  ($data{pubkey}) = $html =~ /<textarea name="pubkey"[^>]+>([^<]+)<\/text/si;

  ## Post the new signature
  $url = "$cfg->{baseurl}/users.pl";
  $ua = LWP::UserAgent->new;
  $ua->agent( $_AGENT_SPOOF );
  $req = HTTP::Request->new(POST => $url);
  $cjar = $cfg->{cookies};
  $cjar->add_cookie_header( $req );
  $req->content_type('application/x-www-form-urlencoded');
  $req->content(join("&",
                     "op=saveuser",
                     "sig=" . uri_escape( $cfg->{sigtext} ),
                     map { "$_=" . uri_escape( $data{$_} || "" ) } keys %data,
                    ));
  $res = $ua->request( $req );
  unless ($res->is_success) {
    print "HTTP Error updating signature: " . $res->status_line . "\n";
    exit(1);
  }
  
  debug("Hopefully updated sig...");
}


############################################################  slash_login  ###
## Login the user & get the cookies
sub slash_login {
  my ($cfg) = @_;
  my ($user, $password) = ($cfg->{user}, $cfg->{password});

  ## Log the user in
  my $url = "$cfg->{baseurl}/users.pl";
  my $ua = LWP::UserAgent->new;
  $ua->agent( $_AGENT_SPOOF );
  my $req = HTTP::Request->new(POST => $url);
  $req->content_type('application/x-www-form-urlencoded');
  $req->content("op=userlogin&upasswd=$password&unickname=$user");
  my $res = $ua->request( $req );

  if ($res->is_error) {
    die( "HTTP Error logging in: " . $res->status_line . "\n" );
  }
  if ($res->as_string =~ /You didn\'t log in/) {
    die( "Error -- login failed!\n" );
  }
  
  ## Get the cookies
  my $cjar = HTTP::Cookies->new;
  $cjar->extract_cookies($res);
  $cfg->{cookies} = $cjar;
  
  debug("Login successful.");
}


###################################################################  init  ###
## Initialization, command-line parsing, etc.
sub init {
  my (%sigmap);
  
  my $usage=<<"__USAGE__";
slashsig.pl --user=<user> --password=<password> [--help] [--version]
             [--siggen=(karma|uptime|quote|rating|karating)]
             [--no-star] [--baseurl=site]


--user        - your slashdot user name
--password    - your slashdot password
--no-star     - turn off the tiny little star that links others
                back to the SlashSig page
--siggen      - how to update your signature
                - karma: with your karma level   (Default)
                - uptime: with your system's uptime
                  (nothing like bragging 'bout your days uptime ;)
--baseurl     - the Slash site to update   (Default: http://slashdot.org)
--quotefile   - file to read quotes from when using siggen=quote
                - default is ~/.slashsigs
                - file format is:
                    sig { optional quote name (unused) } { quote }
                - use --quotefile=~/.gaimrc to use your gaim away messages

  Author: William Reardon, wdr1\@pobox.com
Homepage: http://www.wdr1.com/projects/slashsig/
__USAGE__
  
  my $cfg = {};
  GetOptions($cfg, "help!", "version!", "user=s", "password=s", "quotefile=s",
             "debug+", "siggen=s", "baseurl=s", "no-star!"
            ) || die($usage);

  ## Set debug level
  if ($cfg->{debug}) {
    $_DEBUG_LEVEL = $cfg->{debug};
  }

  ## Version & Help
  if ($cfg->{version}) {
    print "slashsig.pl -- $VERSION\n";
    exit(0);
  }
  if ($cfg->{help}) {
    print $usage;
    exit(0);
  }

  ## Check for user name & password
  unless ($cfg->{user} && $cfg->{password}) {
    die("You must supply both a name & a password!\n");
  }

  ## Set how to get the sig value
  %sigmap = ( 'karma'      => \&get_karma_level,
              'uptime'     => \&get_uptime,
              'quote'      => \&get_quote,
              'rating'     => \&get_slash_rating,
              'karating'   => \&get_karma_and_rating);
  $cfg->{siggen} ||= 'karma';
  $cfg->{'sigfunc'} = $sigmap{ $cfg->{siggen} };

  ## default the baseurl
  $cfg->{baseurl} ||= 'http://slashdot.org';

  # default file
  $cfg->{quotefile} ||= $ENV{HOME}."/.slashsigs";

  return $cfg;
}


##################################################################  debug  ###
## 
sub debug {
  my ($level);

  $level = pop @_;
  if ($level !~ /^\d+$/) {
    push @_, $level;
    $level = 1;
  }

  if ($level <= $_DEBUG_LEVEL) {
    my $str = join("", @_);
    chomp($str);
    print STDERR "DEBUG: $str\n";
  }
}


##############################################################################
##
##              Signature Generation Functions
## 
##############################################################################


########################################################  get_karma_level  ###
## 
sub get_karma_level {
  my ($cfg) = @_;
  my ($karma);
  
  my $url = "$cfg->{baseurl}/users.pl";

  ## Log the user in
  my $ua = LWP::UserAgent->new;
  $ua->agent( $_AGENT_SPOOF );
  my $req = HTTP::Request->new(GET => $url);
  my $cjar = $cfg->{cookies};
  $cjar->add_cookie_header( $req );
  my $res = $ua->request( $req );

  unless ($res->is_success) {
    print "HTTP Error getting karma level: " . $res->status_line . "\n";
    exit(1);
  }
  my $html = $res->as_string();
  
  ($karma) = $html =~ /.*?Karma:(.*?)<br>/si;
  $karma =~ s/<[^>]*>//gsi;
  $karma =~ s/\s{2,}//si;
  $karma =~ s/^\s+//gsi;
  $karma =~ s/\s+$//gsi;
  $karma =~ s/\r\n//gsi;

  $karma = "<B>Karma:</B> $karma";

  $cfg->{sigtext} = $karma;
  
  return $karma;
}


#############################################################  get_uptime  ###
## 
sub get_uptime {
  my ($cfg) = @_;
  
  $cfg->{sigtext} = "<B>uptime:</B> " . `uptime`;
}


##############################################################  get_quote ###
##
sub get_quote {
    my ($cfg) = @_;
    
    my @quotes;
    srand;
    open QUOTES, '<', $cfg->{quotefile}
	or die "Cannot open quote file $cfg->{quotefile}\n";

    while(<QUOTES>){
	/^[\t ]*(message|sig) ({ (.*?) } )?{ (.*?) }/ or next;
	my ( $name, $msg ) = ( $3?$3:"unnamed", $4 );
	
	if (length($msg) > $_MAX_SIG_SIZE){
	    debug("msg '$name' too long (".length($msg)."). skipping...\n",3);
	    next;
	}
	debug("msg '$name' OK\n",3);
	push(@quotes,$msg);
    }
    if (!@quotes){
	print "no valid quotes found, bad quotes file?\n";
	exit;
    }
    my $num = int(rand()*@quotes);
    $cfg->{sigtext} = $quotes[$num];
    debug("using [$num]: '$cfg->{sigtext}'\n",2);
}


######################################################  get_slash_rating  ###
##
sub get_slash_rating {
  my ($cfg) = @_;
  # see http://mshiltonj.com/sr/about.php for more info.
  my $url = 'http://mshiltonj.com/sr/index.php?ss=1&u=' . $cfg->{user};
  my $ua = LWP::UserAgent->new();
  $ua->agent($_AGENT_SPOOF);
  my $req = HTTP::Request->new(GET => $url);
  my $res = $ua->request($req);
  my $rating = '';
  if ($res->is_success()) {
    my $content = $res->content();
    (undef, $rating) = split /:/, $content;
    $cfg->{sigtext} .= ", " if $cfg->{sigtext};
    $cfg->{sigtext} .= "<b>Rating:</b> " . $rating;
  } else {
    print STDERR "HTTP Error getting slash rating: " . $res->status_line() . "\n";
  }
}

###################################################  get_karma_and_rating  ###
##
sub get_karma_and_rating {
  &get_karma_level;
  &get_slash_rating;
}
