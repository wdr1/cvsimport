#!/usr/local/bin/perl -w
package Linkblog;

## Core linkblog application
##
## $Id: Linkblog.pm,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $
##

use strict;
use base 'CGI::Application';

use CGI;
use CGI::Session;
use CGI::Session::Auth::DBI;
use CGI::Carp qw|cluck|;
use URI::Escape;
use Template;
use Data::Dumper;

use Debug;
use Linkblog::DB;
use Linkblog::TT;
use Linkblog::Email;
use Scalar::Util;

our $VERSION = '$Revision: 1.1.1.1 $ ';

our ( $cgi, $session, $auth );
our $DEFAULT_MODE = "welcome";
our $CGI;  # legit
our $SELF; # hack

our $TT_CONFIG = {
  INCLUDE_PATH => [
                   'templates',
                   'static',
                   'templates/static',
                   'templates/includes',
                   # For batch jobs we need the full path
                   '/home/wdr1/Sandboxes/wdr1/Linkblog/templates',
                   '/home/wdr1/Sandboxes/wdr1/Linkblog/templates/static',
                   '/home/wdr1/Sandboxes/wdr1/Linkblog/templates/includes',
                  ],
  INTERPOLATE  => 1,
  POST_CHOMP   => 1,
  PRE_CHOMP    => 1,
  EVAL_PERL    => 1,
};

sub setup {
  my $self = shift;

  ## Fuck around with the default mode a little
  if (lc($ENV{'HTTP_HOST'}) eq 'my.linkblog.org') {
    $DEFAULT_MODE = "my";
  }
  if (lc($ENV{'SCRIPT_NAME'}) eq '/users') {
    $DEFAULT_MODE = "v";
    my $cgi = $self->query();
    my $u = $ENV{'PATH_INFO'};
    $u =~ s|^/||;
    $cgi->param('u', $u);
  }
  $self->start_mode($DEFAULT_MODE);

  my $cgi = $self->query();
  my $u = $cgi->param('u');
  
  $self->mode_param('a');    # The default 'rm' is just disturbing.
  $self->run_modes(
                   "anyone"           => "anyone",
                   "dump"             => "dump",
                   "dumper"           => "dump",
                   "v"                => "view_blog",
                   "welcome"          => "show_welcome",
                   "members"          => "members",
                   "show_login"       => "show_login",
                   "login"            => "login_user",
                   "logout"           => "logout_user",
                   "show_add_link"    => "show_add_link",
                   "sal"              => "show_add_link",
                   "al"               => "add_link",
                   "delete_link"      => "delete_link",
                   "edit"             => "show_my_links",
                   "my"               => "show_calendar_links",
                   "delete"           => "delete_link",
                   "delete_all"       => "delete_all_links",
                   "static"           => "show_static_content",
                   "show_download"    => "show_download",
                   "contact"          => "show_contact",
                   "show_create"      => "show_create_user",
                   "prefs"            => "show_prefs",
                   "save_prefs"       => "save_prefs",
                   "create_user"      => "create_user",
                   "rss"              => "view_rss",
                   "blog"             => "blog_list_links",
                   "show"             => "generic_show",
                   ## Forgot Password stuff
                   "r_pw1"            => "recover_get_email",
                   "r_pw2"            => "recover_send_email",
                   "r_pw3"            => "recover_change_password",
  );

}


sub cgiapp_init {
  my $self = shift;

  $CGI = $self->query();
  $SELF = $self;
}
#####################################################################
##
##  Dummy Show funtions
##
#####################################################################
###########################################################  generic_show  ###
## 
sub generic_show {
  my $self = shift;
  my $cgi = $self->query();

  my $f = $cgi->param('f');
  $f =~ s/[^\w_]/_/g;
  $f .= "static/$f.tt";
  
  return &render_template( $f );  
}


sub show_download {
  my $self = shift;
  
  return &render_template( 'show_download.tt' );  
}

sub show_prefs {
  my $self = shift;
  my (%h);

  return $self->show_login_page() unless ( $self->is_logged_in() );
  $h{ user } = $auth->profile( 'username' );

  ## Now set the HTML value
  $h{'vis'}  = $auth->profile( 'au_public_flag' ) eq 'T' ? 'CHECKED' : '';
  $h{'desc'} = $auth->profile( 'au_ask_desc_flag' ) eq 'T' ? 'CHECKED' : '';

  return &render_template( 'prefs.tt', \%h );  
}

sub show_contact {
  my $self = shift;

  return &render_template( 'contact.tt' );  
}

sub show_create_user {
  my $self = shift;
  my $cgi = $self->query();

  my $data = {};
  foreach my $i (qw|log_username email email2|) {
    $data->{ $i } = $cgi->param( $i );
  }

  return &render_template( 'show_create_user.tt', $data );  
}


########################################################  blog_list_links  ###
## 
sub blog_list_links {
  my ($self) = @_;

  $self->view_blog( 'blog_list_links.tt' );
}


##############################################################  view_blog  ###
## 
sub view_blog {
  my ($self, $f) = @_;
  my $cgi = $self->query();

  $f ||= 'calendar_links.tt';
  my $user      = $cgi->param( 'u' );
  my $max_count = $cgi->param( 'max_count' ) || 9999999;
  
  return &graceful_error( "Whose linkblog did you want to look at?" )
    unless ($user);

  unless( Linkblog::DB::is_linkblog_public( $user ) ) {
    return &graceful_error( "Sorry, but $user's linkblog isn't public.  If you are $user, you can view your linkblog <A HREF='http://my.linkblog.org/'>here</A>." )
  }

  my $h = &Linkblog::DB::get_user_links( $user );  
  $h->{ 'user' }      = $user;
  $h->{ 'max_count' } = $max_count;

  return &render_template($f, $h);  
}


#############################################################  view_links  ###
## 
sub view_links {
  my $self = shift;
  my $cgi = $self->query();

  my $user = $cgi->param( 'u' );
  my $template = $cgi->param('t');
  my $max_links = $cgi->param('ml') || 20 ;
  return &graceful_error( "Whose linkblog did you want to look at?" )
    unless ($user);

  ## Get the user's links
  unless( Linkblog::DB::is_linkblog_public( $user ) ) {
    return &graceful_error( "Sorry, but $user's linkblog isn't public.  If you are $user, you can view your linkblog <A HREF='http://my.linkblog.org/'>here</A>." )
  }
  my $h = &Linkblog::DB::get_user_links( $user );  
  
  my $cnt = $h->{ 'links_count' } < $max_links
    ? $h->{ 'links_count' } : $max_links ;
  my @links = @{ $h->{links} };
#   for (0 .. $cnt) {
#     my $l = shift @links;
#     $rss->add_item (
#                     'title' => $l->{'lk_title'},
#                     'link'  => $l->{'lk_url'},
#                     'description' => $l->{'lk_description'} || ""
#                     );
#   }
#   $rss->{output} = $version;
#   $self->header_props(-type=>'application/xml');
  
#   return $rss->as_string;
}




###############################################################  view_rss  ###
## 
sub view_rss {
  my $self = shift;
  my $cgi = $self->query();

  ## Load the RSS module lazily
  require XML::RSS; import XML::RSS;
  
  my $user = $cgi->param( 'u' );
  my $version = $cgi->param( 'v' ) || '1.0';
  return &graceful_error( "Whose linkblog did you want to look at?" )
    unless ($user);

  ## Get the user's links
  unless( Linkblog::DB::is_linkblog_public( $user ) ) {
    return &graceful_error( "Sorry, but $user's linkblog isn't public.  If you are $user, you can view your linkblog <A HREF='http://my.linkblog.org/'>here</A>." )
  }
  my $h = &Linkblog::DB::get_user_links( $user );  
  
  ## Generate the RSS feed
  my $rss = new XML::RSS( 'version' => 1.0 );
  $rss->channel( title => "${user}'s linkblog",
                 link  => "http://linkblog.org/?u=$user" );

  my $cnt = $h->{ 'links_count' } < 20 ? $h->{ 'links_count' } : 20 ;
  my @links = @{ $h->{links} };
  for (0 .. $cnt) {
    my $l = shift @links;
    $rss->add_item (
                    'title' => $l->{'lk_title'},
                    'link'  => $l->{'lk_url'},
                    'description' => $l->{'lk_description'} || ""
                    );
  }
  $rss->{output} = $version;
  $self->header_props(-type=>'application/xml');
  
  return $rss->as_string;
}




#########################################################  graceful_error  ###
## 
sub graceful_error {
  my ($msg) = @_;

  my %h;
  return &render_template( 'error.tt',
                           { 'error' => $msg } );
}


###################################################################  dump  ###
## 
sub dump {
  my $self = shift;
  my $cgi = $self->query();

  my $html = "<TABLE>\n";
  $html .= '<TR><TD COLSPAN="2"><B>CGI Params</B></TD></TR>';
  foreach my $i (sort $cgi->param() ) {
    $html .= "<TR><TD>'$i'</TD><TD>=&gt;</TD><TD>'" . $cgi->param($i) . "'</TD></TR>\n";
  }
  $html .= "</TABLE>\n";
  $html .= "<HR>";

  $html .= "<TABLE>\n";
  $html .= '<TR><TD COLSPAN="2"><B>ENV</B></TD></TR>';
  foreach my $i (sort keys %ENV) {
    $html .= "<TR><TD>'$i'</TD><TD>=&gt;</TD><TD>'" . $ENV{$i} . "'</TD></TR>\n";
  }

  return $html;
}


#####################################################################
##
##  Admin Functions (create account, etc.)
##
#####################################################################

#############################################################  save_prefs  ###
## 
sub save_prefs {
  my $self = shift;
  my $cgi = $self->query();

  ## Make sure they are logged in & the referer is us
  return $self->show_login_page() unless ( $self->is_logged_in() );
  &_check_referer();

  my %h = ();
  $h{ user } = $auth->profile( 'username' );

  ## What's the CGI & DB value
  $h{'desc'} = $cgi->param('desc');
  $h{'desc'} = $h{'desc'} ? 'T' : 'F';
  $h{'vis'}  = $cgi->param('vis');
  $h{'vis'}  = $h{'vis'} ? 'T' : 'F';

  ## Update the DB if appropiate
  if ($h{'vis'} ne $auth->profile( 'au_public_flag' )) {
    $h{'vis_updated'}  = 1;
  }
  if ($h{'desc'} ne $auth->profile( 'au_ask_desc_flag' )) {
    $h{'desc_updated'}  = 1;
  }
  if ($h{'vis_updated'} || $h{'desc_updated'}) {
    &Linkblog::DB::update_db_prefs( $h{user}, $h{vis}, $h{desc} );
  }
  
  ## Now set the HTML value
  $h{'desc'} = $h{'desc'} eq 'T' ? 'CHECKED' : '';
  $h{'vis'}  = $h{'vis'}  eq 'T' ? 'CHECKED' : '';

  return &render_template( 'prefs.tt', \%h );  
}


sub create_user {
  my $self = shift;
  my @errors = ();
  my $cgi = $self->query();

  debug( "Creating User" );
  ## Sanity Checks
  unless ( $cgi->param( 'email' ) ) {
    push @errors, "Missing email address.";
  }
  unless ( $cgi->param( 'email2' ) ) {
    push @errors, "Missing email address confirmation.";
  }
  unless ( $cgi->param( 'log_password' ) ) {
    push @errors, "Missing password.";
  }
  unless ( $cgi->param( 'log_password2' ) ) {
    push @errors, "Missing password confirmation.";
  }
  unless ( $cgi->param( 'email' ) eq $cgi->param( 'email2' ) ) {
    push @errors, "Email addresses don't match.";
  }
  unless ( $cgi->param( 'log_password' ) eq $cgi->param( 'log_password2' ) ) {
    push @errors, "Passwords don't match.";
  }
  if ( Linkblog::DB::does_user_exist( $cgi->param( 'log_username' ) ) ) {
    unshift @errors, "User already exists.";
  }
  
  unless( @errors ) {
    my $error =   &Linkblog::DB::create_user( $cgi->param( 'log_username' ),
                                              $cgi->param( 'email' ),
                                              $cgi->param( 'log_password' ) );
    if ( $error ) {
      push @errors, $error;
    }
  }

  if (@errors) {
    my $data = {};
    foreach my $i (qw|log_username email email2|) {
      $data->{ $i } = $cgi->param( $i );
    }
    $data->{'errors'} = \@errors;
    return &render_template( 'show_create_user.tt',
                             $data );  
  } else {
    return &render_template( 'create_user_success.tt' );
  }
  
}

#####################################################################
##
##  Linkblog Functions
##
#####################################################################
sub delete_link {
  my $self = shift;

  ## Make sure they are logged in & the referer is us
  return $self->show_login_page() unless ( $self->is_logged_in() );
  &_check_referer();

  my $cgi = $self->query();
  my $lk_id = $cgi->param('i');
  my $user = $auth->profile( 'username' );
  
  &Linkblog::DB::inactivate_link( $user, $lk_id );
    
  return $self->show_my_links();
  
}

sub delete_all_links {
  my $self = shift;

  ## Make sure they are logged in & the referer is us
  return $self->show_login_page() unless ( $self->is_logged_in() );
  &_check_referer();
  
  my $user = $auth->profile( 'username' );
  
  &Linkblog::DB::delete_user_links( $user );
    
  return $self->_show_links( $user );
}


sub show_add_link {
  my $self = shift;

  return $self->show_login_page() unless ( $self->is_logged_in() );

  ## Either prompt for information or throw over to adding
  ## the link straight away.
  if ( $auth->profile( 'au_ask_desc_flag' ) eq 'F' ) {
    return $self->add_link();
  }

  
  my $query = $self->query();
  my $data = { 'd' => $query->param( 'd' ) || "",
               'l' => $query->param( 'l' ) || "",
               'r' => $query->param( 'r' ) || "",
               't' => $query->param( 't' ) || "",
             };
  
  return &render_template( 'show_add_link.tt', $data );  
}


############################################################  delete_link  ###
## 
sub ZZZdelete_link {
  my $self = shift;

  return $self->show_login_page() unless ( $self->is_logged_in() );

  my $query = $self->query();
  my $id = $query->param( 'i' );
  my $user = $auth->profile( 'username' );

  &delete_link( $user, $id );
  
  return $self->show_my_link();
}


sub show_welcome {
  my $self = shift;

  return &render_template( 'show_welcome.tt' );  
}


sub add_link {
  my $self = shift;

  return $self->show_login_page() unless ( $self->is_logged_in() );

  my $cgi = $self->query;
  my $url = $cgi->param('l');
  my $title = $cgi->param('t');
  $title ||= $url;
  my $description = $cgi->param('d') || undef;
  my $referrer = $cgi->param('r') || undef;
  
  my $user = $auth->profile( 'username' );

  &Linkblog::DB::add_link( $user, $url, $title, $referrer, $description );  

  return &render_template( 'post_add_link.tt' );  
}


sub show_my_links {
  my ($self, $template) = @_;
  
  return $self->show_login_page() unless ( $self->is_logged_in() );
  my $user = $auth->profile( 'username' );
  
  my $h = &Linkblog::DB::get_user_links( $user );  
  $h->{ 'user' } = $user;
  $h->{ public } = $auth->profile( 'au_public_flag' ) eq 'T' ? 1 : 0 ;

  $template ||= 'show_my_links.tt';

  return &render_template( $template, $h);  
}


sub show_calendar_links {
  my $self = shift;
  
  return $self->show_my_links( 'calendar_links.tt' );
}

sub show_raw_links {
  my $self = shift;
  
  return $self->show_my_links( 'raw_links.tt' );
}


#####################################################################
##
##  Login Functions
##
#####################################################################

sub logout_user {
  my $self = shift;

  $self->_init_login();
  $auth->logout();

    return &render_template( 'logout.tt' );
}

sub login_user {
  my $self = shift;

  if ( $self->is_logged_in() ) {
    my $r = $cgi->param('r') ||
      $cgi->url( -full => 1 ) . "?a=$DEFAULT_MODE";

    my $cookie = $auth->sessionCookie();
    if ($cgi->param('remember') eq 'on') {
      $cookie->expires( '+3M' );
    }
    
    $self->header_type('redirect');
    $self->header_props(
      -cookie => $cookie,
      -url    => $r,
    );
  }
  else {
    my %h;
    $h{ error } = "Sorry, but you failed to login.";
    $h{ redirect } = $cgi->param('r') ||
      $cgi->url( -full => 1 ) . "?a=$DEFAULT_MODE";
    return &render_template( 'login.tt', \%h );
    return "You failed to log in.";
  }
}

sub is_logged_in {
  my $self = shift;
  my ($bounce) = @_;

  $self->_init_login();
  $auth->authenticate();

  if ( $auth->loggedIn() ) {
    return 1;
  } else {
    unless ($bounce) {
      return 0;
    } else {
      $self->show_login_page();
    }
  }
}

sub show_login_page() {
  my $self = shift;
  my $cgi  = $self->query();
  my %h;

  $h{'redirect'} = $cgi->url(
                             -relative => 1,
                             -query    => 1
                            );
  $h{'nonav'} = $cgi->param('nonav') || 0;
  
  return &render_template( 'login.tt', \%h );
}

sub _init_login {
  my $self = shift;

  $cgi     = $self->query();
  $session = new CGI::Session( undef, $cgi, { Directory => '/tmp' } );
  $auth    = new CGI::Session::Auth::DBI(
    {
      CGI     => $cgi,
      Session => $session,
      Log     => 1,
      DSN     => 'dbi:mysql:database=linkblog',
      DBUser  => 'linkblog',
    }
  );

}

#####################################################################
##
##  General Functions
##
#####################################################################


## TODO: Make this both a function & a method
sub render_template {
  my ( $file, $data ) = @_;

  my $t = Template->new($TT_CONFIG);

  if ($SELF->query->param('dump') ) {
    $data->{'data'} = { %$data };
    
    $SELF->header_add( -type => 'text/plain');
    $file = 'dumper.tt';
  }

  $data->{ 'trim_url'} = \&Linkblog::TT::trim_url ;

  my $output;
  $t->process( $file, $data, \$output )
    || confess( $t->error() );

  return $output;
}


sub _check_referer {
  my $referrer = $ENV{HTTP_REFERER};
  my $host = $ENV{SERVER_NAME};
  $host =~ s/^.*([^\.]+\.com)$/$1/;
  $host =~ s/^www//;

  if ($referrer =~ /$host/) {
    return 1;
  } else {
    croak("Invalid referer!");
  }
  
}

##############################################################################
##
## Forgot Email Functions
##
##############################################################################

######################################################  recover_get_email  ###
## 
sub recover_get_email {
  my $self = shift;
  my ($message) = @_;
  my ($data);

  $data->{message} = $message;
  
  return &render_template( 'forgot_password.tt', $data );  
}

#####################################################  recover_send_email  ###
## 
sub recover_send_email {
  my $self = shift;
  my $data = {};
  
  my $cgi = $self->query();
  my $email = $cgi->param('email');
  $email =~ s/^\s*(.*)\s*$/$1/;

  unless ($email) {
    $self->recover_get_email("Please enter your email address.");
  }
  
  my ($id, $time) = Linkblog::DB::recover_email($email);
  if ($id) {
  } else {
    $self->recover_get_email("Sorry, but '$email' not found.");
  }

  require URI::Escape;
  import URI::Escape;
  
  my $url_email = uri_escape( $email );
  
  my $m =
    Linkblog::Email::send_password_recovery_email( $email, $url_email,
                                                   $id, $time);
  $data->{ 'message' } = $m;

  return &render_template( 'email_sent.tt', $data );
}


################################################  recover_change_password  ###
## 
sub recover_change_password {
  my $self = shift;

  my $MAX_TIME_INTERVAL = 24 * 3600; # one day


  my $f = 'reset_password.tt';
  my $data = {};
  my $cgi = $self->query();
  
  my $email = $cgi->param('e');
  my $i = $cgi->param('i');
  my $t = $cgi->param('t');

  my ($db_i, $db_t ) = Linkblog::DB::get_recover_email_values( $email );

  ## Make sure values match what's in the DB
  if ($i != $db_i && $t != $db_t) {
    $data->{error} = "Sorry, that URL is invalid.";
    return &render_template('error.tt', $data);
  }

  ## Make sure it's not expired
  if (time - $t > $MAX_TIME_INTERVAL) {
    $data->{error} = "Sorry, that URL is invalid.";
    return &render_template('error.tt', $data);
  }

  my $p1 = $cgi->param('password1');
  my $p2 = $cgi->param('password2');

  if ($p1 || $p2) {
    if ($p1 ne $p2) {
      $data->{error} = "Passwords don't match.";
      return &render_template($f, $data);
    }

    my $rv = Linkblog::DB::change_password( $email, $p1 );
    return &render_template('password_changed.tt', $data);
  } else {
    $data->{ i } = $i;
    $data->{ t } = $t;
    $data->{ e } = $email;
    return &render_template($f, $data);
  }
  
}

return 1;
