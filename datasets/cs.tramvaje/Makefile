SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='tramvaje'; " \
" DELETE FROM dataset_sources WHERE dataset='tramvaje'; " \
" INSERT INTO dataset_sources VALUES('tramvaje', 2007, 'http://www.dpp.cz'); " \
" INSERT INTO datasets VALUES ('tramvaje', 1, 'zastavky', 'id, zastavka'); " \
" INSERT INTO datasets VALUES ('tramvaje', 2, 'linky',    'linka, poradi, zastavka_id'); " \
" REVOKE ALL   ON TABLE zastavky FROM PUBLIC; " \
" GRANT SELECT ON TABLE zastavky TO PUBLIC; " \
" REVOKE ALL   ON TABLE linky    FROM PUBLIC; " \
" GRANT SELECT ON TABLE linky    TO PUBLIC; " 

all : .tmp.cs.tramvaje
.tmp.cs.tramvaje : Makefile *.sql
	@psql  $(SQLTUTORDB) < tramvaje.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
