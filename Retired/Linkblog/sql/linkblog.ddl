DROP TABLE IF EXISTS auth_user;

CREATE TABLE auth_user (
  userid varchar(32) NOT NULL default '',
  username varchar(30) NOT NULL default '',
  passwd varchar(30) NOT NULL default '',
  au_id mediumint(9) NOT NULL auto_increment,
  au_email varchar(255) NOT NULL default '',
  au_public_flag char(1) NOT NULL default 'T',
  au_session_length int(11) NOT NULL default '0',
  au_ask_desc_flag char(1) NOT NULL default 'F',
  PRIMARY KEY  (au_id,userid),
  UNIQUE KEY username (username),
  KEY idx_auth_user_userid (userid),
  KEY idx_auth_user_au_email (au_email)
) TYPE=MyISAM;

DROP TABLE IF EXISTS links;

CREATE TABLE links (
	lk_id MEDIUMINT NOT NULL AUTO_INCREMENT,	
	au_id MEDIUMINT NOT NULL,
	lk_url TEXT not null,
	lk_title TEXT null,
	lk_referrer TEXT null,
	lk_description TEXT null,
	lk_crt_ts TIMESTAMP not null,
  lk_active CHAR(1) DEFAULT 'Y',
	PRIMARY KEY (lk_id), 
	INDEX idx_link_au_id( au_id ),
	INDEX idx_link_lk_crt_ts( lk_crt_ts )	
);

