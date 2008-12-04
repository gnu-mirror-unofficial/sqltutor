CLEANFILES = .tmp.cs.pracoviste
EXTRA_DIST = pracoviste.sql

all :

install : .tmp.cs.pracoviste

.tmp.cs.pracoviste :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/pracoviste.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('pracoviste', 2007, 'Pavel Stěhule')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('pracoviste', 1, 'pracoviste',  'kod, popis')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('pracoviste', 2, 'zamestnanci', 'id, jmeno, prijmeni, pracoviste_kod, vek')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('pracoviste', 3, 'mzdy', 'id, vlozeno, zamestnanec_id, castka')"
	@touch $@
