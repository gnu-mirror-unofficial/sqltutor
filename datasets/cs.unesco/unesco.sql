/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008  Ales Cepek <cepek@gnu.org>
 
   GNU Sqltutor is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   GNU Sqltutor is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with GNU Sqltutor.  If not, see <http://www.gnu.org/licenses/>.
 */


SET search_path TO sqltutor;

-- Světové kulturní a přírodní dědictví (UNESCO)

DROP TABLE unesco CASCADE;

CREATE TABLE unesco (
   pamatka      VARCHAR(200) NOT NULL,
   kategorie    VARCHAR(20)  NOT NULL,
   zeme         VARCHAR(60)  NOT NULL,
   region       VARCHAR(50)  NOT NULL,
   zapis        INTEGER      NOT NULL,
   doplneni     VARCHAR(30)  NULL
);



BEGIN;

INSERT INTO unesco ( pamatka, kategorie, zeme, region, zapis, doplneni ) 
   SELECT description, category, country, region, inscription, extension FROM unesco_wh;

UPDATE unesco SET kategorie='přírodní' WHERE kategorie='natural';
UPDATE unesco SET kategorie='kulturní' WHERE kategorie='cultural';
UPDATE unesco SET kategorie='smíšená'  WHERE kategorie='mixed';

UPDATE unesco SET zeme='Republic of Congo'  WHERE zeme LIKE 'Democratic%Congo';
UPDATE unesco SET zeme='United Kingdom'  WHERE zeme LIKE 'United Kingdom of Great%';
UPDATE unesco SET zeme='Macedonia' WHERE zeme LIKE 'the Former Yugoslav Republic of Macedonia%';
UPDATE unesco SET zeme='Tanzania' WHERE zeme LIKE 'United Republic of Tanzania';
UPDATE unesco SET zeme='Venezuela' WHERE zeme LIKE 'Venezuela%Bolivarian%';
UPDATE unesco SET zeme='Korea' WHERE zeme LIKE 'Democratic%Korea';
UPDATE unesco SET zeme='Iran' WHERE zeme LIKE 'Iran%Islamic%';
UPDATE unesco SET zeme='Lao' WHERE zeme LIKE 'Lao%Republic%';
UPDATE unesco SET zeme='Israel' WHERE zeme LIKE 'Jerusalem%Jordan%';
-- UPDATE unesco SET zeme='Central African Rep.' WHERE zeme LIKE 'Central African Republic';
UPDATE unesco SET zeme='Libya' WHERE zeme LIKE 'Libyan Arab Jamahiriya';
UPDATE unesco SET zeme='Syria' WHERE zeme LIKE 'Syrian%Republic%';
-- UPDATE unesco SET zeme='USA' WHERE zeme LIKE 'United%America';
UPDATE unesco SET zeme='Korea' WHERE zeme LIKE 'Republic%Korea';
-- UPDATE unesco SET zeme='Dominican Rep.' WHERE zeme LIKE 'Dominican%Republic';
UPDATE unesco SET zeme='Moldova' WHERE zeme LIKE 'Republic%Moldova';

UPDATE unesco SET region='North America' 
WHERE zeme IN ('Canada', 'United States of America');
UPDATE unesco SET region='Europe' WHERE region='Europe and North America';
UPDATE unesco SET region='Latin America' WHERE region='Latin America and the Caribbean';
UPDATE unesco SET region='Asia & Pacific' WHERE region='Asia and the Pacific';

UPDATE unesco SET pamatka='Jesuit Missions of the Guaranis'
WHERE pamatka LIKE 'Jesuit Missions of the Guaranis:%'; 
UPDATE unesco SET pamatka='Historic Centre of Rome, the Properties of the Holy See'
WHERE pamatka LIKE 'Historic Centre of Rome, the Properties of the Holy See in%'; 
UPDATE unesco SET pamatka='Historic centre of town Chorá'
WHERE pamatka LIKE 'Historic Centre (Chorá)%'; 
UPDATE unesco SET pamatka='Cilento and Vallo di Diano National Park'
WHERE pamatka LIKE 'Cilento and Vallo di Diano National Park with%'; 
UPDATE unesco SET pamatka='18th-Century Royal Palace at Caserta'
WHERE pamatka LIKE '18th-Century Royal Palace at Caserta with%'; 
UPDATE unesco SET pamatka=' Kutná Hora: Historical Town Centre with the Church of St Barbara'
WHERE pamatka LIKE 'Kutná Hora: Historical Town Centre with the Church of St Barbara and%'; 
UPDATE unesco SET pamatka='Kalwaria Zebrzydowska'
WHERE pamatka LIKE 'Kalwaria Zebrzydowska:%'; 
UPDATE unesco SET pamatka='The Four Lifts on the Canal du Centre and their Environs'
WHERE pamatka LIKE 'The Four Lifts on the Canal du Centre and their Environs,%'; 
UPDATE unesco SET pamatka='Haeinsa Temple Janggyeong Panjeon'
WHERE pamatka LIKE 'Haeinsa Temple Janggyeong Panjeon,%'; 
UPDATE unesco SET pamatka='Banks of the Danude, Buda Castle Quarter and Andrássy Avenue'
WHERE pamatka LIKE 'Budapest, including%'; 
UPDATE unesco SET pamatka='Ouadi Qadisha and the Forest of the Cedars of God'
WHERE pamatka LIKE 'Ouadi Qadisha (the Holy Valley)%'; 
UPDATE unesco SET pamatka='Central University City Campus of the Universidad Nacional Autónoma de México'
WHERE pamatka LIKE 'Central University City Campus%(UNAM)%'; 
UPDATE unesco SET pamatka='Vat Phou and Associated Ancient Settlements'
WHERE pamatka LIKE 'Vat Phou%Settlements within the Champasak Cultural Landscape%'; 
UPDATE unesco SET pamatka='Archaeological Landscape of the First Coffee Plantations'
WHERE pamatka LIKE 'Archaeological Landscape%Plantations in the South-East of Cuba%'; 
UPDATE unesco SET pamatka='Architectural, Residential and Cultural Complex of the Radziwill Family at Nesvizh'
WHERE pamatka LIKE 'Architectural, Residential and Cultural Complex of the Radziwill Family at Nesvizh%'; 
UPDATE unesco SET pamatka='Architectural Complex of the Radziwill Family'
WHERE pamatka LIKE 'Architectural, Residential and Cultural Complex of the Radziwill Family at Nesvizh%'; 
UPDATE unesco SET pamatka='Saint-Sophia Cathedral and Related Monastic Buildings'
WHERE pamatka LIKE '%Kiev: Saint-Sophia%Monastic Buildings, Kiev-Pechersk Lavra%'; 

COMMIT;
