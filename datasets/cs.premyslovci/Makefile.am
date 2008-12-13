CLEANFILES = lock..cs.premyslovci
EXTRA_DIST = premyslovci.sql

all :

install : lock..cs.premyslovci

lock..cs.premyslovci :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/premyslovci.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('premyslovci', 2007, 'http://www.vicher.cz/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('premyslovci', 1, 'premyslovci', 'id, jmeno, narozeni, umrti, otec, matka, rod')"
	@touch $@
