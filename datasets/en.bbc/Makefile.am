CLEANFILES = lock..en.bbc
EXTRA_DIST = bbc.sql

all :

install : lock..en.bbc

lock..en.bbc :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/bbc.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('bbc', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('bbc', 1, 'bbc', 'name, region, area, population, gdp')"
	@touch $@
