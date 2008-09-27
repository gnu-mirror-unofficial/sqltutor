SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='nobel'; " \
" DELETE FROM dataset_sources WHERE dataset='nobel'; " \
" INSERT INTO dataset_sources VALUES('nobel', 2008, 'http://sqlzoo.net/'); " \
" INSERT INTO datasets VALUES ('nobel', 1, 'nobel', 'yr, subject, winner'); " \
" REVOKE ALL   ON TABLE nobel FROM PUBLIC; " \
" GRANT SELECT ON TABLE nobel TO PUBLIC; " 


all : .tmp.en.nobel
.tmp.en.nobel : Makefile *.sql
	@psql  $(SQLTUTOR_DATABASE) < nobel.sql
	@echo  $(SQL) | psql $(SQLTUTOR_DATABASE) 
	@touch $@
