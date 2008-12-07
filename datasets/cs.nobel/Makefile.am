CLEANFILES = .tmp.cs.nobel
EXTRA_DIST = nobelova_cena.sql

install : .tmp.cs.nobel

.tmp.cs.nobel : ../en.nobel/.tmp.en.nobel
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/nobelova_cena.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('nobelova_cena', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('nobelova_cena', 1, 'nobelova_cena', 'rok, obor, nositel')"
	@touch $@

../en.nobel/.tmp.en.nobel :
	make -C ../en.nobel install
