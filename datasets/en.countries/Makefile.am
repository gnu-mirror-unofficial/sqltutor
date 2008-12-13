CLEANFILES = lock..en.countries
EXTRA_DIST = countries.sql \
             country_codes.sql \
             national_capitals.sql \
             table_tennis.sql \
             un_regions.sql     

all :

install : lock..en.countries

lock..en.countries :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/countries.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/country_codes.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/un_regions.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/national_capitals.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/table_tennis.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('countries', 2008, 'http://wikipedia.org/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 1, 'country_codes', 'a2, a3, num, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 2, 'un_regions', 'region, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 3, 'un_regions_countries', 'region, country')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 4, 'national_capitals', 'coutry, city, population, area')"
	@touch $@
