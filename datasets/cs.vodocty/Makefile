SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='vodocty'; " \
" DELETE FROM dataset_sources WHERE dataset='vodocty'; " \
" INSERT INTO dataset_sources VALUES('vodocty', 2007, 'http://hydro.chmi.cz/hpps/op_list.php'); " \
" INSERT INTO datasets VALUES ('vodocty', 1, 'toky',      'id, jmeno'); " \
" INSERT INTO datasets VALUES ('vodocty', 2, 'stanice',   'id, nazev'); " \
" INSERT INTO datasets VALUES ('vodocty', 3, 'vodocty',   'tok_id, stanice_id, cas, vodocet_cm'); " \
" INSERT INTO datasets VALUES ('vodocty', 4, 'limity_cm', 'tok_id, stanice_id, bdelost, pohotovost, ohrozeni'); " \
" INSERT INTO datasets VALUES ('vodocty', 5, 'cleneni',   'tok_id, stanice_id, kraj, pobocka, povodi'); " \
" REVOKE ALL   ON TABLE toky      FROM PUBLIC; " \
" GRANT SELECT ON TABLE toky      TO PUBLIC; " \
" REVOKE ALL   ON TABLE stanice   FROM PUBLIC; " \
" GRANT SELECT ON TABLE stanice   TO PUBLIC; " \
" REVOKE ALL   ON TABLE limity_cm FROM PUBLIC; " \
" GRANT SELECT ON TABLE limity_cm TO PUBLIC; " \
" REVOKE ALL   ON TABLE cleneni   FROM PUBLIC; " \
" GRANT SELECT ON TABLE cleneni   TO PUBLIC; " 


all : .tmp.cs.vodocty
.tmp.cs.vodocty : Makefile *.sql
	@psql  $(SQLTUTORDB) < vodocty.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
