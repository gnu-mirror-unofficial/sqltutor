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

DROP TABLE dopravni_letadla CASCADE;

CREATE TABLE dopravni_letadla (
    id           integer  PRIMARY KEY,
    vyrobce      varchar(20)  NOT NULL,
    letadlo      varchar(20)  NOT NULL,
    dolet_km     integer,
    kapacita     integer,
    v_provozu_od integer
);

BEGIN;

INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 1, 'Airbus', 'A300' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 2, 'Airbus', 'A310' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 3, 'Airbus', 'A318' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 4, 'Airbus', 'A319' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 5, 'Airbus', 'A320' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 6, 'Airbus', 'A321' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 7, 'Airbus', 'A330' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 8, 'Airbus', 'A340' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 9, 'Airbus', 'A380' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 10, 'Antonov', 'An-10' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 11, 'Antonov', 'An-12' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 12, 'Antonov', 'An-26' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 13, 'Antonov', 'An-72' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 14, 'Antonov', 'An-74' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 15, 'ATR', 'ATR-42' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 16, 'ATR', 'ATR-72' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 17, 'BAe', '146-100' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 18, 'BAe', '146-200' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 19, 'BAe', '146-300' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 20, 'BAe', '748' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 21, 'BAe', 'ATP' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 22, 'BAe', 'Jetstream 31' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 23, 'BAe', 'RJ100' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 24, 'BAe', 'RJ70' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 25, 'BAe', 'RJ85' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 26, 'Boeing', '707' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 27, 'Boeing', '717' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 28, 'Boeing', '720' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 29, 'Boeing', '727' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 30, 'Boeing', '737' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 31, 'Boeing', '747' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 32, 'Boeing', '757' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 33, 'Boeing', '767' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 34, 'Boeing', '777' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 35, 'Boeing', '787' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 36, 'Bombardier', 'CRJ-100' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 37, 'Bombardier', 'CRJ-200' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 38, 'Bombardier', 'CRJ-700' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 39, 'Bombardier', 'CRJ-900' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 40, 'Convair', '580' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 41, 'De Havilland', 'Comet' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 42, 'De Havilland', 'DHC-7' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 43, 'De Havilland', 'DHC-8' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 44, 'Dornier', '328' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 45, 'Dornier', '328JET' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 46, 'Dornier', 'Do-228' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 47, 'Embraer', 'EMB-110' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 48, 'Embraer', 'EMB-120' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 49, 'Embraer', 'ERJ-135' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 50, 'Embraer', 'ERJ-145' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 51, 'Embraer', 'ERJ-170' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 52, 'Embraer', 'ERJ-190' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 53, 'Fairchild', 'Metro 23' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 54, 'Fairchild', 'Metro I' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 55, 'Fairchild', 'Metro III' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 56, 'Fokker', 'F-27' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 57, 'Fokker', 'F-28' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 58, 'Fokker', 'F-50' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 59, 'Fokker', 'F-70' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 60, 'Fokker', 'F-100' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 61, 'Ilyushin', 'Il-14' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 62, 'Ilyushin', 'Il-18' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 63, 'Ilyushin', 'Il-76T' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 64, 'Lockheed', 'Electra' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 65, 'Lockheed', 'Hercules' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 66, 'McDonnell Douglas', 'Douglas DC-10' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 67, 'McDonnell Douglas', 'Douglas DC-8' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 68, 'McDonnell Douglas', 'Douglas DC-9' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 69, 'McDonnell Douglas', 'MD-11' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 70, 'McDonnell Douglas', 'MD-11CF' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 71, 'McDonnell Douglas', 'MD-11ER' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 72, 'McDonnell Douglas', 'MD-11F' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 73, 'McDonnell Douglas', 'MD-82' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 74, 'McDonnell Douglas', 'MD-83' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 75, 'McDonnell Douglas', 'MD-87' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 76, 'McDonnell Douglas', 'MD-88' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 77, 'McDonnell Douglas', 'MD-90' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 78, 'Raytheon Beech', '1900D' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 79, 'Saab', 'Saab 2000' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 80, 'Saab', 'Saab 340' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 81, 'Short', 'Skyvan' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 82, 'Sud Aviation', 'Caravelle' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 83, 'Tupolev', 'Tu-104' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 84, 'Tupolev', 'Tu-124' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 85, 'Tupolev', 'Tu-134' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 86, 'Tupolev', 'Tu-154M' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 87, 'Vickers', 'VC-10' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 88, 'Vickers', 'Viscount' );
INSERT INTO dopravni_letadla (id, vyrobce, letadlo) VALUES ( 89, 'Yakovlev', 'Yak-42D' );

COMMIT;
