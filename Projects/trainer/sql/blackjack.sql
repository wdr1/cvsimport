CREATE TABLE IF NOT EXISTS ut_blackjack (
  id                       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name                     VARCHAR(128) NOT NULL,
  email                    VARCHAR(128) NOT NULL,
  password                 VARCHAR(128) NOT NULL,
  shoe_type                VARCHAR(128) NOT NULL,
  send_nontraining_emails  BOOL NOT NULL,
  send_training_emails     BOOL NOT NULL,
  PRIMARY KEY (id),
  INDEX (send_nontraining_emails),
  INDEX (send_training_emails),
  INDEX (email)  
);

CREATE TABLE IF NOT EXISTS blackjack LIKE ut_blackjack;

