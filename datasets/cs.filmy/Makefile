SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='filmy'; " \
" DELETE FROM dataset_sources WHERE dataset='filmy'; " \
" INSERT INTO dataset_sources VALUES('filmy', 2007, 'http://www.fdb.cz/'); " \
" INSERT INTO datasets VALUES ('filmy', 1, 'filmy',    'id, rok, titul'); " \
" INSERT INTO datasets VALUES ('filmy', 2, 'umelci',   'id, jmeno'); " \
" INSERT INTO datasets VALUES ('filmy', 3, 'obsazeni', 'film_id, umelec_id, poradi'); " \
" INSERT INTO datasets VALUES ('filmy', 4, 'rezie',    'film_id, umelec_id'); " \
" REVOKE ALL   ON TABLE filmy    FROM PUBLIC; " \
" GRANT SELECT ON TABLE filmy    TO PUBLIC; " \
" REVOKE ALL   ON TABLE umelci   FROM PUBLIC; " \
" GRANT SELECT ON TABLE umelci   TO PUBLIC; " \
" REVOKE ALL   ON TABLE obsazeni FROM PUBLIC; " \
" GRANT SELECT ON TABLE obsazeni TO PUBLIC; " \
" REVOKE ALL   ON TABLE rezie    FROM PUBLIC; " \
" GRANT SELECT ON TABLE rezie    TO PUBLIC; " 


all : .tmp.cs.filmy
.tmp.cs.filmy : Makefile *.sql
	@psql  $(SQLTUTORDB) < filmy.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
