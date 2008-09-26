SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='letadla'; " \
" DELETE FROM dataset_sources WHERE dataset='letadla'; " \
" INSERT INTO dataset_sources VALUES('letadla', 2007, 'http://www.letadla.info/'); "\
" INSERT INTO datasets VALUES ('letadla', 1, 'dopravni_letadla',    'id, vyrobce, letadlo, dolet_km, kapacita, v_provozu_od'); " \
" INSERT INTO datasets VALUES ('letadla', 2, 'letecke_spolecnosti', 'id, spolecnost, zeme, svetadil, aliance, zalozeno'); " \
" INSERT INTO datasets VALUES ('letadla', 3, 'letecke_flotily',     'spolecnost_id, letadlo_id, pocet_letadel'); " \
" REVOKE ALL   ON TABLE dopravni_letadla    FROM PUBLIC; " \
" GRANT SELECT ON TABLE dopravni_letadla    TO PUBLIC; " \
" REVOKE ALL   ON TABLE letecke_spolecnosti FROM PUBLIC; " \
" GRANT SELECT ON TABLE letecke_spolecnosti TO PUBLIC; " \
" REVOKE ALL   ON TABLE letecke_flotily     FROM PUBLIC; " \
" GRANT SELECT ON TABLE letecke_flotily     TO PUBLIC; " 


all : .tmp.cs.letadla
.tmp.cs.letadla : Makefile *.sql
	@psql  $(SQLTUTORDB) < ciselnik_letadel.sql
	@psql  $(SQLTUTORDB) < dopravni_letadla.sql
	@psql  $(SQLTUTORDB) < letecke_spolecnosti.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
