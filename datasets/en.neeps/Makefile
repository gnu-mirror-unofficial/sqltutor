SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='neeps'; " \
" DELETE FROM dataset_sources WHERE dataset='neeps'; " \
" INSERT INTO datasets VALUES ('neeps', 1, 'week', 'id, wkstart'); " \
" INSERT INTO datasets VALUES ('neeps', 2, 'room', 'id, name, capacity, parent'); " \
" INSERT INTO datasets VALUES ('neeps', 3, 'modle', 'id, name'); " \
" INSERT INTO datasets VALUES ('neeps', 4, 'event', 'id, modle, kind, dow, tod, duration, room'); " \
" INSERT INTO datasets VALUES ('neeps', 5, 'occurs', 'event, week'); " \
" INSERT INTO datasets VALUES ('neeps', 6, 'student', 'id, name, sze, parent'); " \
" INSERT INTO datasets VALUES ('neeps', 7, 'staff', 'id, name'); " \
" INSERT INTO datasets VALUES ('neeps', 8, 'attends', 'student, event'); " \
" INSERT INTO datasets VALUES ('neeps', 9, 'teaches', 'staff, event'); " \
" REVOKE ALL   ON TABLE week    FROM PUBLIC; " \
" GRANT SELECT ON TABLE week    TO PUBLIC; " \
" REVOKE ALL   ON TABLE room    FROM PUBLIC; " \
" GRANT SELECT ON TABLE room    TO PUBLIC; " \
" REVOKE ALL   ON TABLE modle   FROM PUBLIC; " \
" GRANT SELECT ON TABLE modle   TO PUBLIC; " \
" REVOKE ALL   ON TABLE event   FROM PUBLIC; " \
" GRANT SELECT ON TABLE event   TO PUBLIC; " \
" REVOKE ALL   ON TABLE occurs  FROM PUBLIC; " \
" GRANT SELECT ON TABLE occurs  TO PUBLIC; " \
" REVOKE ALL   ON TABLE student FROM PUBLIC; " \
" GRANT SELECT ON TABLE student TO PUBLIC; " \
" REVOKE ALL   ON TABLE staff   FROM PUBLIC; " \
" GRANT SELECT ON TABLE staff   TO PUBLIC; " \
" REVOKE ALL   ON TABLE attends FROM PUBLIC; " \
" GRANT SELECT ON TABLE attends TO PUBLIC; " \
" REVOKE ALL   ON TABLE teaches FROM PUBLIC; " \
" GRANT SELECT ON TABLE teaches TO PUBLIC; " 


all : .tmp.en.neeps
.tmp.en.neeps : Makefile *.sql
	@psql  $(SQLTUTOR_DATABASE) < neeps.sql
	@echo  $(SQL) | psql $(SQLTUTOR_DATABASE) 
	@touch $@


