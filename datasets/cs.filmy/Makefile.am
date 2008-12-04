CLEANFILES = .tmp.cs.filmy
EXTRA_DIST = filmy.sql

all : 

install : .tmp.cs.filmy

.tmp.cs.filmy : 
	-psql $(SQLTUTOR_DATABASE) < $(srcdir)/filmy.sql
	@psql $(SQLTUTOR_DATABASE) -c "SELECT sqltutor.init_dataset('filmy', 2007, 'http://www.fdb.cz/')"
	@psql $(SQLTUTOR_DATABASE) -c "SELECT sqltutor.add_ds_table('filmy', 1, 'filmy',    'id, rok, titul')"
	@psql $(SQLTUTOR_DATABASE) -c "SELECT sqltutor.add_ds_table('filmy', 2, 'umelci',   'id, jmeno')"
	@psql $(SQLTUTOR_DATABASE) -c "SELECT sqltutor.add_ds_table('filmy', 3, 'obsazeni', 'film_id, umelec_id, poradi')"
	@psql $(SQLTUTOR_DATABASE) -c "SELECT sqltutor.add_ds_table('filmy', 4, 'rezie',    'film_id, umelec_id')"
	@touch $@
