SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='movies'; " \
" DELETE FROM dataset_sources WHERE dataset='movies'; " \
" INSERT INTO dataset_sources VALUES('movies', 2008, 'http://sqlzoo.net/'); " \
" INSERT INTO datasets VALUES ('movies', 1, 'actor',   'id, name'); " \
" INSERT INTO datasets VALUES ('movies', 2, 'movie',   'id, title, yr, score, votes, director'); " \
" INSERT INTO datasets VALUES ('movies', 3, 'casting', 'movieid, actorid, ord'); " \
" REVOKE ALL   ON TABLE actor   FROM PUBLIC; " \
" GRANT SELECT ON TABLE actor   TO PUBLIC; " \
" REVOKE ALL   ON TABLE movie   FROM PUBLIC; " \
" GRANT SELECT ON TABLE movie   TO PUBLIC; " \
" REVOKE ALL   ON TABLE casting FROM PUBLIC; " \
" GRANT SELECT ON TABLE casting TO PUBLIC; " 


all : .tmp.en.movies
.tmp.en.movies : Makefile *.sql
	@psql  $(SQLTUTOR_DATABASE) < movies.sql
	@echo  $(SQL) | psql $(SQLTUTOR_DATABASE) 
	@touch $@
