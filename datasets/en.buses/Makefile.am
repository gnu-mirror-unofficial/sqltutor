CLEANFILES = .tmp.en.buses
EXTRA_DIST = buses.sql

all :

install : .tmp.en.buses

.tmp.en.buses :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/buses.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('buses', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('buses', 1, 'stops',   'id, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('buses', 2, 'route',   'num, company, pos, stop')"
	@touch $@
