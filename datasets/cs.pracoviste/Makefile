SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='pracoviste'; " \
" DELETE FROM dataset_sources WHERE dataset='pracoviste'; " \
" INSERT INTO dataset_sources VALUES('pracoviste', 2007, 'Pavel Stěhule'); " \
" INSERT INTO datasets VALUES ('pracoviste', 1, 'pracoviste',  'kod, popis'); " \
" INSERT INTO datasets VALUES ('pracoviste', 2, 'zamestnanci', 'id, jmeno, prijmeni, pracoviste_kod, vek'); " \
" INSERT INTO datasets VALUES ('pracoviste', 3, 'mzdy', 'id, vlozeno, zamestnanec_id, castka'); " \
" REVOKE ALL   ON TABLE pracoviste  FROM PUBLIC; " \
" GRANT SELECT ON TABLE pracoviste  TO PUBLIC; " \
" REVOKE ALL   ON TABLE zamestnanci FROM PUBLIC; " \
" GRANT SELECT ON TABLE zamestnanci TO PUBLIC; " \
" REVOKE ALL   ON TABLE mzdy        FROM PUBLIC; " \
" GRANT SELECT ON TABLE mzdy        TO PUBLIC; " 


all : .tmp.cs.pracoviste
.tmp.cs.pracoviste : Makefile *.sql
	@psql  $(SQLTUTORDB) < pracoviste.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
