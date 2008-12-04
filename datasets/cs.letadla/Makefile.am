CLEANFILES = .tmp.cs.letadla
EXTRA_DIST = ciselnik_letadel.sql dopravni_letadla.sql letecke_spolecnosti.sql

all :

install : .tmp.cs.letadla

.tmp.cs.letadla :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/ciselnik_letadel.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/dopravni_letadla.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/letecke_spolecnosti.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('letadla', 2007, 'http://www.letadla.info/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('letadla', 1, 'dopravni_letadla',    'id, vyrobce, letadlo, dolet_km, kapacita, v_provozu_od')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('letadla', 2, 'letecke_spolecnosti', 'id, spolecnost, zeme, svetadil, aliance, zalozeno')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('letadla', 3, 'letecke_flotily',     'spolecnost_id, letadlo_id, pocet_letadel')"
	@touch $@
