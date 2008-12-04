CLEANFILES = .tmp.en.countries
EXTRA_DIST = countries.sql

all :

install : .tmp.en.countries

.tmp.en.countries :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/countries.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('countries', 2008, 'http://wikipedia.org/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 1, 'country_codes', 'a2, a3, num, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 2, 'un_regions', 'region, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 3, 'un_regions_countries', 'region, country')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('countries', 4, 'national_capitals', 'coutry, city, population, area')"
	@touch $@
