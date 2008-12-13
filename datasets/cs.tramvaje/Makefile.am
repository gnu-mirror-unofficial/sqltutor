CLEANFILES = lock..cs.tramvaje
EXTRA_DIST = tramvaje.sql

all :

install : lock..cs.tramvaje

lock..cs.tramvaje :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/tramvaje.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('tramvaje', 2008, 'http://www.dp-praha.cz')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('tramvaje', 1, 'zastavky', 'id, zastavka')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('tramvaje', 2, 'linky',    'linka, smer, poradi, zastavka_id')"
	@touch $@
