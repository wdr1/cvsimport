#!/usr/local/bin/perl -w

package Linkblog::DB;

use 5.008;
use strict;
use Carp qw|cluck croak|;
use Data::Dumper;
use DBI;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();

our $VERSION = '0.01';

## CGI::Session::Auth::DBI creates a db handle to the same database,
## but screw 'em, we'll have our own for now.
our $dbh;
our $_inited;
our %DB_CONFIG = (
  'dsn' => "DBI:mysql:database=linkblog",
  'user' => 'linkblog',
  'password' => '',
  'dbi_attr' => { 
    RaiseError => 1,
    PrintError => 1,
    AutoCommit => 1,
  }
);

our %STH;


sub get_recover_email_values {
  my ($email) = @_;
  
  ## Check required params
  cluck("Missing email!") unless ($email);

  &_init_db_handle();

  my $sql =<<"__SQL__";
SELECT au_recover_id, UNIX_TIMESTAMP(au_recover_date)
  FROM auth_user
 WHERE au_email = ?
__SQL__
  my $sth = $dbh->prepare( $sql );
  $sth->execute( $email );
  my ($i, $t) = $sth->fetchrow_array();

  return ($i, $t);
}


sub change_password {
  my ($email, $password) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing email!") unless ($email);

  &_init_db_handle();
  my $sql =<<"__SQL__";
UPDATE auth_user
   SET passwd = ?,
       au_recover_date = NULL,
       au_recover_id = NULL
 WHERE au_email = ?
__SQL__
  $sth = $dbh->prepare( $sql );
  my $rv = $sth->execute( $password, $email );

  return $rv;
}

sub recover_email {
  my ($email) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing email!") unless ($email);

  &_init_db_handle();

  if ($STH{'get_user_links'}) {
    $sth = $STH{'_user2id'};
  } else {
    my $sql =<<"__SQL__";
UPDATE auth_user
   SET au_recover_id = ?,
       au_recover_date = FROM_UNIXTIME(?)
 WHERE au_email = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'get_user_links'} = $sth;    
  }

  my $id = int(rand(4294967295));
  my $time = time;
  my $rv = $sth->execute($id, $time, $email);

  if ($rv eq 0) {
    return;
  } elsif ($rv > 1) {
    die("More than one row updated!? (rv: '$rv')");
  } else {
    return ($id, $time, $email);
  }
}


sub add_link {
  my ($user, $url, $title, $referrer, $description) = @_;
  
  my $uid = &_user2id( $user );
  &_insert_link( $uid, $url, $title, $referrer, $description);
}


sub get_user_links {
  my ($user) = @_;
  my ($sth);
  
  cluck("Missing user!") unless ($user);
  &_init_db_handle();
  my $uid = &_user2id( $user );
  
  if ($STH{'get_user_links'}) {
    $sth = $STH{'_user2id'};
  } else {
    my $sql =<<"__SQL__";
    SELECT lk_id, au_id, lk_url, lk_title, lk_referrer, lk_description,
           UNIX_TIMESTAMP(lk_crt_ts) as lk_crt_ts
      FROM links
     WHERE au_id = ?
       AND lk_active = 'Y'
    ORDER BY lk_crt_ts DESC
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'get_user_links'} = $sth;    
  }

  $sth->execute($uid);

  my (@links, $count);
  while ( my $row = $sth->fetchrow_hashref() ) {
    push @links, { %$row };
    $count++;
  }
  
  my %h = ( 'links' => \@links,
            'links_count' => $count );
  return \%h;
}


sub _user2id {
  my ($user) = @_;
  my ($sth);
  
  cluck("Missing user!") unless ($user);
  &_init_db_handle();
  
  if ($STH{'_user2id'}) {
    $sth = $STH{'_user2id'};
  } else {
    my $sql =<<"__SQL__";
    SELECT *
      FROM auth_user
     WHERE username = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'_user2id'} = $sth;    
  }

  $sth->execute($user);
  my $row = $sth->fetchrow_hashref('NAME_uc');
  my $uid = $row->{ 'AU_ID' };
  croak("Couldn't find au_id for '$user'!  Exiting!") unless ($uid);
  
  return $uid;  
}

sub _insert_link {
  my ($au_id, $url, $title, $referrer, $description) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing au_id!") unless ($au_id);
  cluck("Missing url!") unless ($url);
  
  &_init_db_handle();

  ## Prepare and cache the statement handle  
  if ($STH{'insert'}) {
    $sth = $STH{'insert'};
  } else {
    my $sql =<<"__SQL__";
INSERT INTO links
  (au_id, lk_url, lk_title, lk_referrer, lk_description, lk_crt_ts)
VALUES
  (?, ?, ?, ?, ?, NOW())
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'insert'} = $sth;    
  }

  $sth->execute($au_id, $url, $title, $referrer, $description);
  
  return 1;
}


#####################################################  is_linkblog_public  ###
## 
sub is_linkblog_public {
  my ($user) = @_;
  my ($sth);
  
  ## Check required params
  cluck("Missing user!") unless ($user);
  
  &_init_db_handle();

  ## Prepare and cache the statement handle  
  if ($STH{'is_linkblog_public'}) {
    $sth = $STH{'is_linkblog_public'};
  } else {
    my $sql = "SELECT au_public_flag FROM auth_user WHERE username = ?";    
    $sth = $dbh->prepare( $sql );
    $STH{'is_linkblog_public'} = $sth;    
  }

  $sth->execute($user);
  my ($rv) = $sth->fetchrow_array();
  $rv = $rv eq 'T' ? 1 : 0; 

  return $rv;
}


sub delete_link {
  my ($user, $lk_id) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing user!") unless ($user);
  cluck("Missing lk_id!") unless ($lk_id);
  
  &_init_db_handle();
  my $au_id = &_user2id( $user );
  
  ## Prepare and cache the statement handle  
  if ($STH{'delete_link'}) {
    $sth = $STH{'delete_link'};
  } else {
    my $sql =<<"__SQL__";
DELETE FROM link WHERE lk_id = ? AND au_id = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'delete_link'} = $sth;    
  }

  $sth->execute($au_id, $lk_id);
  
  return 1;
}


########################################################  update_db_prefs  ###
## 
sub update_db_prefs {
  my ($user, $pub, $desc) = @_;
  my ($sth);
  
  ## Check required params
  cluck("Missing user!") unless ($user);
  
  &_init_db_handle();
  my $au_id = &_user2id( $user );
  
  ## Update the prefs if desired
  if ($pub) {
    if ($STH{'update_db_prefs_pub'}) {
      $sth = $STH{'update_db_prefs_pub'};
    } else {
      my $sql =<<"__SQL__";
UPDATE auth_user SET au_public_flag = ? WHERE au_id = ?
__SQL__
      $sth = $dbh->prepare( $sql );
      $STH{'update_db_prefs_pub'} = $sth;    
    }
    $sth->execute($pub, $au_id);
    die("ERROR: Update failed!") if ($sth->rows() == 0);
  }
  
  ## Update the desc if desired
  if ($desc) {
    if ($STH{'update_db_prefs_desc'}) {
      $sth = $STH{'update_db_prefs_desc'};
    } else {
      my $sql =<<"__SQL__";
UPDATE auth_user SET au_ask_desc_flag = ? WHERE au_id = ?
__SQL__
      $sth = $dbh->prepare( $sql );
      $STH{'update_db_prefs_desc'} = $sth;    
    }
    $sth->execute($desc, $au_id);
    die("ERROR: Update failed!") if ($sth->rows() == 0);
  }
  
  return 1;
}




sub inactivate_link {
  my ($user, $lk_id) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing user!") unless ($user);
  cluck("Missing lk_id!") unless ($lk_id);
  
  &_init_db_handle();
  my $au_id = &_user2id( $user );
  
  ## Prepare and cache the statement handle  
  if ($STH{'inactivate_link'}) {
    $sth = $STH{'inactivate_link'};
  } else {
    my $sql =<<"__SQL__";
UPDATE links SET lk_active = 'N' WHERE lk_id = ? AND au_id = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'inactivate_link'} = $sth;    
  }

  print STDERR ("au_id: $au_id     lk_id: $lk_id\n");
  $sth->execute($lk_id, $au_id);
  die("Failed to remove link!") if ($sth->rows() == 0); 
  
  return 1;
}


############################################################  create_user  ###
## 
sub create_user {
  my ($user, $email, $password) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing user!") unless ($user);
  cluck("Missing email!") unless ($email);
  cluck("Missing password!") unless ($password);
  &_init_db_handle();

  if (&does_email_exist($email)) {
    return "That email address is already in use.";
  }
  
  if ($STH{'create_user'}) {
    $sth = $STH{'create_user'};
  } else {
    my $sql =<<"__SQL__";
INSERT INTO auth_user
  (userid, username, passwd, au_email, au_crt_ts)
VALUES
  (?, ?, ?, ?, NOW()) 
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'create_user'} = $sth;    
  }
  my $id = CGI::Session::Auth::uniqueUserID( $user );
  
  my $rv = $sth->execute($id, $user, $password, $email);

  if ($rv == 1) {
    $rv = undef;
  } else {
    debug("Failed to insert into database: ", Dumper( \@_ ));
    $rv = "Insert failed!";
  }
  
  return $rv;
}

########################################################  does_user_exist  ###
## 
sub does_user_exist {
  my ($user) = @_;
  my ($sth);
  
  ## Check required params
  cluck("Missing user!") unless ($user);
  &_init_db_handle();
  
  if ($STH{'does_user_exist'}) {
    $sth = $STH{'does_user_exist'};
  } else {
    my $sql =<<"__SQL__";
SELECT 1 FROM auth_user WHERE username = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'does_user_exist'} = $sth;    
  }
  
  $sth->execute($user);
  my $row = scalar @{ $sth->fetchall_arrayref };

  return $row;
}


########################################################  does_email_exist  ###
## 
sub does_email_exist {
  my ($email) = @_;
  my ($sth);
  
  ## Check required params
  cluck("Missing email!") unless ($email);
  &_init_db_handle();
  
  if ($STH{'does_email_exist'}) {
    $sth = $STH{'does_email_exist'};
  } else {
    my $sql =<<"__SQL__";
SELECT 1 FROM auth_user WHERE au_email = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'does_email_exist'} = $sth;    
  }
  
  $sth->execute($email);
  my $row = scalar @{ $sth->fetchall_arrayref };

  return $row;
}


sub delete_user_links {
  my ($user) = @_;
  my ($sth);

  ## Check required params
  cluck("Missing user!") unless ($user);
  
  &_init_db_handle();
  my $au_id = &_user2id( $user );
  
  ## Prepare and cache the statement handle  
  if ($STH{'delete_link'}) {
    $sth = $STH{'delete_link'};
  } else {
    my $sql =<<"__SQL__";
DELETE FROM link WHERE au_id = ?
__SQL__
    $sth = $dbh->prepare( $sql );
    $STH{'delete_link'} = $sth;    
  }

  $sth->execute($au_id);
  
  return 1;
}

sub reset {
  $dbh->disconnect() if ($_inited);
  $_inited = 0;
  &_init_db_handle();  
}


sub _init_db_handle {
  return 1 if ($_inited);  
  
  $dbh = DBI->connect( $DB_CONFIG{'dsn'},
                       $DB_CONFIG{'user'},      
                       $DB_CONFIG{'password'},
                       $DB_CONFIG{'dbi_attr'},
                     );

  return $dbh;
}

1;
