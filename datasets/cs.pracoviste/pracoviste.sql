/* 
   This file is public domain.

   The data is a matter of public record, and comes from
   Pavel Stehule  http://www.postgres.cz/index.php/Pavel_Stehule
 */


SET search_path TO sqltutor;

DROP TABLE Pracoviste CASCADE;
DROP TABLE Zamestnanci CASCADE;
DROP TABLE Mzdy CASCADE;

CREATE TABLE Pracoviste(
  kod char(2) PRIMARY KEY,
  popis varchar(20) UNIQUE NOT NULL CHECK (popis <> '')
);

CREATE TABLE Zamestnanci(
  id SERIAL PRIMARY KEY,
  jmeno varchar(20) NOT NULL CHECK (jmeno <> ''),
  prijmeni varchar(20) NOT NULL CHECK (prijmeni <> ''),
  pracoviste_kod char(2) NOT NULL REFERENCES pracoviste(kod),
  vek integer NOT NULL CHECK(vek > 0)
);

CREATE TABLE Mzdy(
  id SERIAL PRIMARY KEY,
  vlozeno date NOT NULL DEFAULT(CURRENT_DATE),
  zamestnanec_id integer NOT NULL REFERENCES Zamestnanci(id),
  castka NUMERIC(8,2) NOT NULL CHECK (castka > 0.0)
);

INSERT INTO Pracoviste VALUES('kc','Konstrukce');
INSERT INTO Pracoviste VALUES('pr','Provoz');
INSERT INTO Pracoviste VALUES('sk','Sekretariat');
INSERT INTO Pracoviste VALUES('vy','Vyroba');
INSERT INTO Pracoviste VALUES('it','Informatika');

-- SELECT * FROM Pracoviste;

INSERT INTO Zamestnanci(jmeno, prijmeni, pracoviste_kod, vek) VALUES('Pavel', 'Stehule', 'it',33);
INSERT INTO Zamestnanci(jmeno, prijmeni, pracoviste_kod, vek) VALUES('Radek', 'Hirjak', 'kc', 32);
INSERT INTO Zamestnanci(jmeno, prijmeni, pracoviste_kod, vek) VALUES('Jan', 'Pytel', 'it', 31);
INSERT INTO Zamestnanci(jmeno, prijmeni, pracoviste_kod, vek) VALUES('Zdenek', 'Stehule', 'vy', 28);
INSERT INTO Zamestnanci(jmeno, prijmeni, pracoviste_kod, vek) VALUES('Lucie', 'Kubikova', 'sk', 25);
INSERT INTO Zamestnanci(jmeno, prijmeni, pracoviste_kod, vek) VALUES('Tomas', 'Zezula', 'sk', 45);

-- SELECT * FROM Zamestnanci;

INSERT INTO Mzdy VALUES(DEFAULT, '2007-01-01', 1, 30000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-01-01', 2, 25000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-01-01', 3, 28000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-01-01', 4, 20000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-01-01', 5, 18000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-01-01', 6, 50000);

INSERT INTO Mzdy VALUES(DEFAULT, '2007-02-01', 1, 30000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-02-01', 2, 25000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-02-01', 3, 30000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-02-01', 4, 20000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-02-01', 5, 18000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-02-01', 6, 50000);

INSERT INTO Mzdy VALUES(DEFAULT, '2007-03-01', 1, 31000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-03-01', 2, 26000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-03-01', 3, 31000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-03-01', 4, 20000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-03-01', 5, 19000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-03-01', 6, 60000);

INSERT INTO Mzdy VALUES(DEFAULT, '2007-04-01', 1, 30500);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-04-01', 2, 25000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-04-01', 3, 28000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-04-01', 4, 20000);
INSERT INTO Mzdy VALUES(DEFAULT, '2007-04-01', 6, 51000);

-- SELECT * FROM Mzdy;