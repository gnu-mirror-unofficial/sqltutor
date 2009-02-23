/* 
   This file is public domain.

   The data is a matter of public record, and comes from
    http://wikipedia.org/   
 */


SET search_path TO sqltutor;

DROP TABLE country_codes CASCADE;
DROP TABLE national_capitals CASCADE;

CREATE TABLE country_codes 
(
   a2   char(2),
   a3   char(3),
   num  integer,
   name varchar(50),

   PRIMARY KEY (num)
);

CREATE INDEX country_codes_a2  ON country_codes(a2);
CREATE INDEX country_codes_a3  ON country_codes(a3);


CREATE TABLE national_capitals
(
   country     char(3),           -- alpha-3 country code
   city        varchar(40),       -- name
   population  integer,           -- city population 
   area        integer,           -- city area in km^2

   PRIMARY KEY (country)
);


DROP TABLE un_regions CASCADE;
CREATE TABLE un_regions
(
   region integer PRIMARY KEY,
   name   varchar(40) 
);


DROP TABLE un_regions_countries CASCADE;
CREATE TABLE un_regions_countries
(
   region  integer REFERENCES un_regions (region),
   country integer REFERENCES country_codes (num),

   PRIMARY KEY (region, country)
);


