CLEANFILES = .tmp.cs.tramvaje
EXTRA_DIST = tramvaje.sql

all :

install : .tmp.cs.tramvaje

.tmp.cs.tramvaje :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/tramvaje.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('tramvaje', 2007, 'http://www.dpp.cz')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('tramvaje', 1, 'zastavky', 'id, zastavka')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('tramvaje', 2, 'linky',    'linka, poradi, zastavka_id')"
	@touch $@
