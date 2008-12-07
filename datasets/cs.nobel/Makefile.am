CLEANFILES = .tmp.cs.nobel
EXTRA_DIST = nobel.sql

install : .tmp.cs.nobel

.tmp.cs.nobel : ../en.nobel/.tmp.en.nobel
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/nobel.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('nobelova_cena', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('nobelova_cena', 1, 'laureati', 'rok, obor, laureat')"
	@touch $@

../en.nobel/.tmp.en.nobel :
	make -C ../en.nobel install
