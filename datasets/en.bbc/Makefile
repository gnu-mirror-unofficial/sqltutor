SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='bbc'; " \
" DELETE FROM dataset_sources WHERE dataset='bbc'; " \
" INSERT INTO dataset_sources VALUES('bbc', 2008, 'http://sqlzoo.net/'); " \
" INSERT INTO datasets VALUES ('bbc', 1, 'bbc', 'name, region, area, population, gdp'); " \
" REVOKE ALL   ON TABLE bbc FROM PUBLIC; " \
" GRANT SELECT ON TABLE bbc TO PUBLIC; " 


all : .tmp.en.bbc
.tmp.en.bbc : Makefile *.sql
	@psql  $(SQLTUTORDB) < bbc.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
