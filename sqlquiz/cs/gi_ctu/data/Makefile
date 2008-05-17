# Warning: file order processing is important in some datasets

all:
	psql $(DBNAME) < ciselnik_letadel.sql
	psql $(DBNAME) < dopravni_letadla.sql
	psql $(DBNAME) < letecke_spolecnosti.sql
#
	psql $(DBNAME) < unesco_wh.sql
	psql $(DBNAME) < unesco.sql
#
	psql $(DBNAME) < filmy.sql
	psql $(DBNAME) < odsl.sql
	psql $(DBNAME) < premyslovci.sql
	psql $(DBNAME) < staty.sql
	psql $(DBNAME) < tramvaje.sql
	psql $(DBNAME) < vodocty.sql

