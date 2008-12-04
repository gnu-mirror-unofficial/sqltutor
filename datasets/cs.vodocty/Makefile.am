CLEANFILES = .tmp.cs.vodocty
EXTRA_DIST = vodocty.sql

all :

install : .tmp.cs.vodocty

.tmp.cs.vodocty :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/vodocty.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('vodocty', 2007, 'http://hydro.chmi.cz/hpps/op_list.php')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('vodocty', 1, 'toky',      'id, jmeno')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('vodocty', 2, 'stanice',   'id, nazev')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('vodocty', 3, 'vodocty',   'tok_id, stanice_id, cas, vodocet_cm')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('vodocty', 4, 'limity_cm', 'tok_id, stanice_id, bdelost, pohotovost, ohrozeni')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('vodocty', 5, 'cleneni',   'tok_id, stanice_id, kraj, pobocka, povodi')"
	@touch $@
