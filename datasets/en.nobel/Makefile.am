CLEANFILES = .tmp.en.nobel
EXTRA_DIST = nobel.sql

all :

install : .tmp.en.nobel

.tmp.en.nobel :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/nobel.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('nobel', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('nobel', 1, 'nobel', 'yr, subject, winner')"
	@touch $@
