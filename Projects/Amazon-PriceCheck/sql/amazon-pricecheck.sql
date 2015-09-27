## $Id: amazon-pricecheck.sql,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

CREATE TABLE IF NOT EXISTS users (
  id                       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  email                    VARCHAR(255) NOT NULL,
  password                 VARCHAR(128) NOT NULL,
  guid                     VARCHAR(128) NOT NULL,
  crt_ts                   TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  INDEX (guid),
  INDEX (email)  
);


CREATE TABLE IF NOT EXISTS users_x_products (
  id                           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id                      INT UNSIGNED NOT NULL, 
  prod_id                      INT UNSIGNED NOT NULL,
  purchase_price               DECIMAL(9,2),
  lowest_seen_price            DECIMAL(9,2),
  end_ts                       DATETIME NOT NULL,
  crt_ts                       TIMESTAMP NOT NULL,
  email_hash                   VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  INDEX(user_id),
  INDEX(email_hash),
  INDEX(end_ts),
  INDEX(prod_id)
);

CREATE TABLE IF NOT EXISTS products (
  id                       BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  product_name             VARCHAR(255) NOT NULL,
  asin                     VARCHAR(30) NOT NULL,
  last_seen_price          DECIMAL(9,2),
  last_seen_date           DATETIME NOT NULL,
  PRIMARY KEY (id),
  INDEX(product_name),
  INDEX(last_seen_date)
);