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

