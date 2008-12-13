CLEANFILES = lock..cs.staty
EXTRA_DIST = staty.sql

all :

install : lock..cs.staty

lock..cs.staty :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/staty.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('staty', 2006, 'http://unstats.un.org/unsd/demographic/products/socind/inc-eco.htm')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('staty', 1, 'staty', 'stat, region, populace, hdp')"
	@touch $@
