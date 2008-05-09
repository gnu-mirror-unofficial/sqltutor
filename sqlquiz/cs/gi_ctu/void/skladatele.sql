DROP TABLE skladatele CASCADE;
CREATE TABLE skladatele (
   skladatel  VARCHAR(20),
   narozen    INTEGER,
   zemrel     INTEGER
);


INSERT INTO skladatele VALUES ('J. S. Bach',   1685, 1750);
INSERT INTO skladatele VALUES ('W. A. Mozart', 1756, 1791);
INSERT INTO skladatele VALUES ('L. Beethoven', 1770, 1827);
INSERT INTO skladatele VALUES ('F. Chopin',    1810, 1849);
INSERT INTO skladatele VALUES ('R. Schumann',  1810, 1856);
INSERT INTO skladatele VALUES ('B. Bartók',    1881, 1945);