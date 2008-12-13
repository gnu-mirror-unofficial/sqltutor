CLEANFILES = lock..en.neeps
EXTRA_DIST = neeps.sql

all :

install : lock..en.neeps

lock..en.neeps :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/neeps.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('neeps', 2008, 'http://sqlzoo.net')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 1, 'week', 'id, wkstart')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 2, 'room', 'id, name, capacity, parent')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 3, 'modle', 'id, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 4, 'event', 'id, modle, kind, dow, tod, duration, room')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 5, 'occurs', 'event, week')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 6, 'student', 'id, name, sze, parent')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 7, 'staff', 'id, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 8, 'attends', 'student, event')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('neeps', 9, 'teaches', 'staff, event')"
	@touch $@
