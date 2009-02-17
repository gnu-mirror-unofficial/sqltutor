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


DROP   VIEW sqltutor.laureati;
CREATE VIEW sqltutor.laureati (rok, obor, laureat)
AS
SELECT year, CASE subject
               WHEN 'Chemistry'  THEN 'Chemie'
               WHEN 'Economics'  THEN 'Ekomonie'
               WHEN 'Literature' THEN 'Literatura'
               WHEN 'Medicine'   THEN 'Medicína'
               WHEN 'Peace'      THEN 'Mír'
               WHEN 'Physics'    THEN 'Fyzika'
               ELSE subject
             END,
       winner
  FROM sqltutor.nobel;
