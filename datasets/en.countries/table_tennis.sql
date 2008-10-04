SET search_path TO sqltutor;

DROP TABLE olympic_medal_winners CASCADE;
CREATE TABLE olympic_medal_winners 
(
   host_city   varchar(12),
   year        integer,
   discipline  varchar(14),
   event       varchar(15),
   medal       varchar(8),
   nation      varchar(3),
   name        varchar(30) 
);



/* Views needed by SQLzoo.net "The Table Tennis Olympics Database" 
 * ---------------------------------------------------------------
 */

-- ISO 3166 coutry codes standard does not contain former countries
-- like Yugoslavia, which are needed for Olympic medal records.

CREATE VIEW country (id, name) AS
   SELECT *
     FROM (
            SELECT a3, name FROM country_codes
            UNION
            SELECT 'YUG', 'Yugoslavia'   -- YUGOSLAVIA YU YUG 891
          ) AS C;

-- Table Tennis (Men's Singles)

CREATE VIEW ttms (games, color, who, country) AS
   SELECT year, medal, name, nation
     FROM olympic_medal_winners
    WHERE discipline = 'table tennis'
      AND event      = 'singles men';

-- Table Tennis (Men's Singles)

CREATE VIEW ttws (games, color, who, country) AS
   SELECT year, medal, name, nation
     FROM olympic_medal_winners
    WHERE discipline = 'table tennis'
      AND event      = 'singles women';



/*
 * OLYMPIC MEDAL WINNERS
 *
 * http://www.olympic.org/uk/athletes/results/search_r_uk.asp
 *
 * Olympic Games   Discipline    Events  Medal  Nation   Name       
 */


INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles women', 'gold'   , 'KOR', 'HYUN, Jung Hwa');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles women', 'gold'   , 'KOR', 'YANG, Young-Ja');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'singles women', 'gold'   , 'CHN', 'CHEN, Jing');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'DENG, Yaping');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'QIAO, Hong');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles women', 'gold'   , 'CHN', 'DENG, Yaping');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'DENG, Yaping');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'QIAO, Hong');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'singles women', 'gold'   , 'CHN', 'DENG, Yaping');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'LI, Ju');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'WANG, Nan');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'singles women', 'gold'   , 'CHN', 'WANG, Nan');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'WANG, Nan');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles women', 'gold'   , 'CHN', 'ZHANG, Yining');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'singles women', 'gold'   , 'CHN', 'ZHANG, Yining');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles women', 'silver' , 'CHN', 'CHEN, Jing');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles women', 'silver' , 'CHN', 'JIAO, Zhi-Min');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'singles women', 'silver' , 'CHN', 'LI, Hui-Fen');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'silver' , 'CHN', 'CHEN, Zihe');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'silver' , 'CHN', 'GAO, Jun');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles women', 'silver' , 'CHN', 'QIAO, Hong');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles women', 'silver' , 'CHN', 'LIU, Wei');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles women', 'silver' , 'CHN', 'QIAO, Yunping');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'singles women', 'silver' , 'TWN', 'CHEN, Jing');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles women', 'silver' , 'CHN', 'SUN, Jin');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles women', 'silver' , 'CHN', 'YANG, Ying');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'singles women', 'silver' , 'CHN', 'LI, Ju');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles women', 'silver' , 'KOR', 'LEE, Eun Sil');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles women', 'silver' , 'KOR', 'SEOK, Eun Mi');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'singles women', 'silver' , 'PRK', 'KIM, Hyang Mi');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles women', 'bronz'  , 'YUG', 'REED, Jasna');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles women', 'bronz'  , 'YUG', 'PERKUCIN, Gordana');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'singles women', 'bronz'  , 'CHN', 'JIAO, Zhi-Min');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'bronz'  , 'KOR', 'HYUN, Jung Hwa');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'bronz'  , 'KOR', 'HONG, Cha Ok');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'bronz'  , 'PRK', 'LI, Bun Hui');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles women', 'bronz'  , 'PRK', 'YU, Sun Bok');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles women', 'bronz'  , 'KOR', 'HYUN, Jung Hwa');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles women', 'bronz'  , 'PRK', 'LI, Bun Hui');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles women', 'bronz'  , 'KOR', 'PARK, Hae-Jung');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles women', 'bronz'  , 'KOR', 'RYU, Ji-Hye');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'singles women', 'bronz'  , 'CHN', 'QIAO, Hong');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles women', 'bronz'  , 'KOR', 'KIM, Moo-Kyo');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles women', 'bronz'  , 'KOR', 'RYU, Ji-Hye');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'singles women', 'bronz'  , 'TWN', 'CHEN, Jing');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles women', 'bronz'  , 'CHN', 'GUO, Yue');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles women', 'bronz'  , 'CHN', 'NIU, Jianfeng');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'singles women', 'bronz'  , 'KOR', 'KIM, Kyung Ah');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'CHEN, Long-Can');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'WEI, Qing-Guang');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'singles men'  , 'gold'   , 'KOR', 'YOO, Nam-Kyu');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'LU, Lin');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'WANG, Tao');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles men'  , 'gold'   , 'SWE', 'WALDNER, Jan-Ove');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'KONG, Linghui');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'LIU, Guoliang');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'singles men'  , 'gold'   , 'CHN', 'LIU, Guoliang');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'WANG, Liqin');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'YAN, Sen');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'singles men'  , 'gold'   , 'CHN', 'KONG, Linghui');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'CHEN, Qi');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles men'  , 'gold'   , 'CHN', 'MA, Lin');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'singles men'  , 'gold'   , 'KOR', 'RYU, Seung Min');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles men'  , 'silver' , 'YUG', 'LUPULESKU, Ilija');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles men'  , 'silver' , 'YUG', 'PRIMORAC, Zoran');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'singles men'  , 'silver' , 'KOR', 'KIM, Ki Taik');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'silver' , 'DEU', 'FETZNER, Steffen');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'silver' , 'DEU', 'ROSSKOPF, Jörg');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles men'  , 'silver' , 'FRA', 'GATIEN, Jean-Philippe');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles men'  , 'silver' , 'CHN', 'LU, Lin');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles men'  , 'silver' , 'CHN', 'WANG, Tao');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'singles men'  , 'silver' , 'CHN', 'WANG, Tao');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles men'  , 'silver' , 'CHN', 'LIU, Guoliang');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles men'  , 'silver' , 'CHN', 'KONG, Linghui');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'singles men'  , 'silver' , 'SWE', 'WALDNER, Jan-Ove');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles men'  , 'silver' , 'HKG', 'KO, Lai Chak');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles men'  , 'silver' , 'HKG', 'LI, Ching');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'singles men'  , 'silver' , 'CHN', 'WANG, Hao');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'AN, Jae Hyung');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'YOO, Nam-Kyu');
INSERT INTO olympic_medal_winners VALUES('Seoul'    , 1988, 'table tennis', 'singles men'  , 'bronz'  , 'SWE', 'LINDH, Erik');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'KIM, Taek Soo');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'YOO, Nam-Kyu');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'KANG, Hee Chan');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'LEE, Chul Seung');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles men'  , 'bronz'  , 'KOR', 'KIM, Taek Soo');
INSERT INTO olympic_medal_winners VALUES('Barcelona', 1992, 'table tennis', 'singles men'  , 'bronz'  , 'CHN', 'MA, Wenge');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'LEE, Chul Seung');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'doubles men'  , 'bronz'  , 'KOR', 'YOO, Nam-Kyu');
INSERT INTO olympic_medal_winners VALUES('Atlanta'  , 1996, 'table tennis', 'singles men'  , 'bronz'  , 'DEU', 'ROSSKOPF, Jörg');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles men'  , 'bronz'  , 'FRA', 'GATIEN, Jean-Philippe');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'doubles men'  , 'bronz'  , 'FRA', 'CHILA, Patrick');
INSERT INTO olympic_medal_winners VALUES('Sydney'   , 2000, 'table tennis', 'singles men'  , 'bronz'  , 'CHN', 'LIU, Guoliang');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles men'  , 'bronz'  , 'DNK', 'MAZE, Michael');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'doubles men'  , 'bronz'  , 'DNK', 'TUGWELL, Finn');
INSERT INTO olympic_medal_winners VALUES('Athens'   , 2004, 'table tennis', 'singles men'  , 'bronz'  , 'CHN', 'WANG, Liqin');
