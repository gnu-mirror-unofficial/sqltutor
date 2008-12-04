CLEANFILES = .tmp.en.busses
EXTRA_DIST = busses.sql

all :

install : .tmp.en.busses

.tmp.en.busses :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/busses.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('busses', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('busses', 1, 'stops',   'id, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('busses', 2, 'route',   'num, company, pos, stop')"
	@touch $@
