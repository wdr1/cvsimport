DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS authors_x_books;


CREATE TABLE users (
  users_id INT AUTO_INCREMENT NOT NULL,
  users_login varchar(20) NOT NULL,
  users_password varchar(100) NOT NULL,
  chg_ts  TIMESTAMP(14) NOT NULL,
  crt_ts  TIMESTAMP(14) NOT NULL,
  PRIMARY KEY(users_id)  
);


CREATE TABLE books (
  books_id INT AUTO_INCREMENT NOT NULL,
  books_name VARCHAR(255) NOT NULL,
  books_author_dsp VARCHAR(255) NOT NULL,
  books_asin INT NOT NULL,
  PRIMARY KEY(books_id)
);


CREATE TABLE authors (
  authors_id INT AUTO_INCREMENT NOT NULL,
  authors_name VARCHAR(255) NOT NULL
);


CREATE TABLE authors_x_books (
  books_id INT NOT NULL,
  authors_id INT NOT NULL 
);

CREATE TABLE users_x_books (
  users_id INT NOT NULL,
  books_id INT NOT NULL,
  PRIMARY KEY(users_id, books_id),
  INDEX users_id_idx (users_id),  
  INDEX books_id_idx (books_id)
);
