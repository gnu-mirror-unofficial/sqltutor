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


CREATE OR REPLACE FUNCTION sqltutor.init_dataset (
        dataset  text,
        year     int,
        source   text )
RETURNS text 
AS $$
BEGIN
   EXECUTE 'DELETE FROM sqltutor.datasets WHERE dataset=''' 
               || dataset || '''';
   EXECUTE 'DELETE FROM sqltutor.dataset_sources WHERE dataset=''' 
               || dataset || ''''; 
   EXECUTE 'INSERT INTO sqltutor.dataset_sources VALUES('''
               || dataset ||  ''', ' || year || ', ''' || source || ''')';

   RETURN dataset;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.add_ds_table (
        dataset  text,
        ord      int,
        ds_table text,
        columns  text )
RETURNS text
AS $$
BEGIN
   EXECUTE 'INSERT INTO sqltutor.datasets VALUES('''
               || dataset  || ''', ' || ord || ', '''
               || ds_table || ''', ''' || columns || ''')';
   EXECUTE 'REVOKE ALL   ON TABLE sqltutor.' || ds_table || ' FROM PUBLIC;';
   EXECUTE 'GRANT SELECT ON TABLE sqltutor.' || ds_table || ' TO   PUBLIC;';

   RETURN dataset || ' : ' || ds_table;
END
$$ LANGUAGE plpgsql;

