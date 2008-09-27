SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='unesco'; " \
" DELETE FROM dataset_sources WHERE dataset='unesco'; " \
" INSERT INTO dataset_sources VALUES('unesco', 2007, 'http://whc.unesco.org/en/list/'); " \
" INSERT INTO datasets VALUES ('unesco', 1, 'unesco', 'pamatka, kategorie, zeme, region, zapis, doplneni'); " \
" REVOKE ALL   ON TABLE unesco FROM PUBLIC; " \
" GRANT SELECT ON TABLE unesco TO PUBLIC; " \

all : .tmp.cs.unesco
.tmp.cs.unesco : Makefile *.sql
	@psql  $(SQLTUTOR_DATABASE) < unesco_wh.sql
	@psql  $(SQLTUTOR_DATABASE) < unesco.sql
	@echo  $(SQL) | psql $(SQLTUTOR_DATABASE) 
	@touch $@
