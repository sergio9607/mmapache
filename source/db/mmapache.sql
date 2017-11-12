-- =============================================================================
-- Diagram Name: mmapache
-- Created on: Mar 4 12:01:20 AM
-- Diagram Version: 
-- =============================================================================
DROP DATABASE IF EXISTS mapache;

CREATE DATABASE IF NOT EXISTS mapache 
CHARACTER SET utf8 
COLLATE utf8_general_ci;

USE mapache;

SET FOREIGN_KEY_CHECKS=0;

-- Drop table film
DROP TABLE IF EXISTS film;

CREATE TABLE film (
  flm_id varchar(50) NOT NULL,
  flm_mp4 varchar(200) NOT NULL,
  flm_title varchar(100) NOT NULL,
  flm_year year NOT NULL,
  flm_genre varchar(50) NOT NULL,
  flm_rating numeric NOT NULL,
  flm_details varchar(1000) NOT NULL,
  PRIMARY KEY(flm_id)
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table artist
DROP TABLE IF EXISTS artist;

CREATE TABLE artist (
  art_id varchar(50) NOT NULL,
  art_name varchar(100) NOT NULL,
  art_cover varchar(200) NOT NULL,
  PRIMARY KEY(art_id)
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table mapacheuser
DROP TABLE IF EXISTS mapacheuser;

CREATE TABLE mapacheuser (
  usr_username varchar(20) NOT NULL,
  usr_email varchar(50) NOT NULL,
  usr_password varchar(20) NOT NULL,
  usr_type varchar(5) NOT NULL,
  usr_phone varchar(20),
  PRIMARY KEY(usr_username)
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table album
DROP TABLE IF EXISTS album;

CREATE TABLE album (
  alb_id varchar(50) NOT NULL,
  alb_name varchar(100) NOT NULL,
  alb_year year NOT NULL,
  alb_cover varchar(200) NOT NULL,
  alb_art_id varchar(50) NOT NULL,
  PRIMARY KEY(alb_id),
  CONSTRAINT art_albums FOREIGN KEY (alb_art_id)
    REFERENCES artist(art_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table song
DROP TABLE IF EXISTS song;

CREATE TABLE song (
  sng_id varchar(50) NOT NULL,
  sng_mp3 varchar(200) NOT NULL,
  sng_title varchar(100) NOT NULL,
  sng_time time NOT NULL,
  sng_genre varchar(50) NOT NULL,
  sng_alb_id varchar(50) NOT NULL,
  PRIMARY KEY(sng_id),
  CONSTRAINT alb_songs FOREIGN KEY (sng_alb_id)
    REFERENCES album(alb_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table card
DROP TABLE IF EXISTS card;

CREATE TABLE card (
  crd_number char(16) NOT NULL,
  crd_cvv varchar(4) NOT NULL,
  crd_holder varchar(100) NOT NULL,
  crd_issuer varchar(50) NOT NULL,
  crd_usr_username varchar(20) NOT NULL,
  PRIMARY KEY(crd_number),
  CONSTRAINT usr_cards FOREIGN KEY (crd_usr_username)
    REFERENCES mapacheuser(usr_username)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table plan
DROP TABLE IF EXISTS plan;

CREATE TABLE plan (
  pln_id varchar(24) NOT NULL,
  pln_date date NOT NULL,
  pln_music tinyint(1) UNSIGNED NOT NULL,
  pln_video tinyint(1) UNSIGNED NOT NULL,
  pln_usr_username varchar(20) NOT NULL,
  pln_crd_number char(16) NOT NULL,
  PRIMARY KEY(pln_id),
  CONSTRAINT usr_plan FOREIGN KEY (pln_usr_username)
    REFERENCES mapacheuser(usr_username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT crd_plan FOREIGN KEY (pln_crd_number)
    REFERENCES card(crd_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table watchlist
DROP TABLE IF EXISTS watchlist;

CREATE TABLE watchlist (
  wat_usr_username varchar(20) NOT NULL,
  wat_flm_id varchar(50) NOT NULL,
  wat_saved tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  wat_loved tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY(wat_usr_username, wat_flm_id),
  CONSTRAINT flm_watchlist FOREIGN KEY (wat_flm_id)
    REFERENCES film(flm_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT usr_watchlist FOREIGN KEY (wat_usr_username)
    REFERENCES mapacheuser(usr_username)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

-- Drop table library
DROP TABLE IF EXISTS library;

CREATE TABLE library (
  lib_usr_username varchar(20) NOT NULL,
  lib_sng_id varchar(50) NOT NULL,
  lib_saved tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  lib_loved tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY(lib_usr_username, lib_sng_id),
  CONSTRAINT usr_library FOREIGN KEY (lib_usr_username)
    REFERENCES mapacheuser(usr_username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT sng_library FOREIGN KEY (lib_sng_id)
    REFERENCES song(sng_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE=INNODB
CHARACTER SET utf8 
COLLATE utf8_general_ci ;

SET FOREIGN_KEY_CHECKS=1;
