CREATE TABLE users
  (
     id       INTEGER PRIMARY KEY,
     salt     BLOB,
     iv       BLOB,
     username TEXT,
     password BLOB,
     email    TEXT,
     about_me TEXT,
     mode     CHAR,
     staff    INTEGER,
     popcorn  INTEGER,
     premium  INTEGER
  );

CREATE TABLE default_values
  (
     id                INTEGER PRIMARY KEY,
     popcorn_to_pounds REAL,
     premium_price     REAL
  );

CREATE TABLE polls
  (
     id            INTEGER PRIMARY KEY,
     option1       TEXT,
     option1_count INTEGER,
     option2       TEXT,
     option2_count INTEGER,
     option3       TEXT,
     option3_count INTEGER,
     option4       TEXT,
     option4_count INTEGER,
     option5       TEXT,
     option5_count INTEGER
  );

CREATE TABLE chapters
  (
     id        INTEGER PRIMARY KEY,
     title     TEXT,
     content   TEXT,
     cost      INTEGER,
     ch_number INTEGER,
     poll      INTEGER,
     book      INTEGER,
     FOREIGN KEY(poll) REFERENCES polls(id), -- # Why would a poll need to exist before creating a chapter?
     FOREIGN KEY(book) REFERENCES books(id)
  );

CREATE TABLE purchases
  (
     id       INTEGER PRIMARY KEY,
     date     TEXT,
     type     CHAR,
     cost     INTEGER,
     customer INTEGER,
     product  INTEGER,
     FOREIGN KEY(customer) REFERENCES users(id)
  );

CREATE TABLE subscriptions
  (
     id     INTEGER PRIMARY KEY,
     reader INTEGER,
     writer INTEGER,
     FOREIGN KEY(reader) REFERENCES users(id),
     FOREIGN KEY(writer) REFERENCES users(id)
  );

CREATE TABLE books
  (
     id           INTEGER PRIMARY KEY,
     NAME         TEXT,
     genre        TEXT,
     cover        BLOB,
     author       INTEGER,
     flagged      INTEGER,
     last_updated TEXT,
     FOREIGN KEY(author) REFERENCES users(id)
  ); 