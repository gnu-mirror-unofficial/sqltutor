SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='busses'; " \
" DELETE FROM dataset_sources WHERE dataset='busses'; " \
" INSERT INTO dataset_sources VALUES('busses', 2008, 'http://sqlzoo.net/'); " \
" INSERT INTO datasets VALUES ('busses', 1, 'stops',   'id, name'); " \
" INSERT INTO datasets VALUES ('busses', 2, 'route',   'num, company, pos, stop'); " \
" REVOKE ALL   ON TABLE stops FROM PUBLIC; " \
" GRANT SELECT ON TABLE stops TO PUBLIC; " \
" REVOKE ALL   ON TABLE route FROM PUBLIC; " \
" GRANT SELECT ON TABLE route TO PUBLIC; " 


all : .tmp.en.busses
.tmp.en.busses : Makefile *.sql
	@psql  $(SQLTUTOR_DATABASE) < busses.sql
	@echo  $(SQL) | psql $(SQLTUTOR_DATABASE) 
	@touch $@
