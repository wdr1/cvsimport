-- Bookshelf Mysql Setup Script
--
-- 1) mysqladmin --user=root create Bookshelf
--
-- 2) mysql --root=user mysql < setup.sql
--

GRANT ALL PRIVILEGES ON bookshelf.* TO bookshelf@localhost
    IDENTIFIED BY 'libris' WITH GRANT OPTION;

