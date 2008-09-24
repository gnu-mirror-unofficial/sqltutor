SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='filmy'; " \
" DELETE FROM dataset_sources WHERE dataset='filmy'; " \
" INSERT INTO dataset_sources VALUES('filmy',       2007, 'http://www.fdb.cz/'); "\
" INSERT INTO datasets VALUES ('filmy', 1, 'filmy',    'id, rok, titul'); " \
" INSERT INTO datasets VALUES ('filmy', 2, 'umelci',   'id, jmeno'); " \
" INSERT INTO datasets VALUES ('filmy', 3, 'obsazeni', 'film_id, umelec_id, poradi'); " \
" INSERT INTO datasets VALUES ('filmy', 4, 'rezie',    'film_id, umelec_id'); "


all:
	@psql $(SQLTUTORDB) < filmy.sql
	@echo $(SQL) | psql $(SQLTUTORDB) 

