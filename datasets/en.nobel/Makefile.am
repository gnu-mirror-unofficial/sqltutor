CLEANFILES = lock..en.nobel
EXTRA_DIST = nobel.sql

all :

install : lock..en.nobel

lock..en.nobel :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/nobel.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('nobel', 2008, 'http://nobelprize.org/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('nobel', 1, 'nobel', 'year, subject, winner')"
	@touch $@
