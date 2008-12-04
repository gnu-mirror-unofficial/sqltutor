CLEANFILES = .tmp.cs.unesco
EXTRA_DIST = unesco.sql \
             unesco_wh.sql

all :

install : .tmp.cs.unesco

.tmp.cs.unesco :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/unesco_wh.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/unesco.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('unesco', 2007, 'http://whc.unesco.org/en/list/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('unesco', 1, 'unesco', 'pamatka, kategorie, zeme, region, zapis, doplneni')"
	@touch $@
