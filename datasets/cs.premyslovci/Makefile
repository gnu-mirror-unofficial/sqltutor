SQL = \
" SET search_path TO sqltutor; " \
" INSERT INTO dataset_sources VALUES('premyslovci', 2007, 'http://www.vicher.cz/'); " \
" INSERT INTO datasets VALUES ('premyslovci', 1, 'premyslovci', 'id, jmeno, narozeni, umrti, otec, matka, rod'); " \
" REVOKE ALL   ON TABLE premyslovci    FROM PUBLIC; " \
" GRANT SELECT ON TABLE premyslovci    TO PUBLIC; " 


all : .tmp.cs.premyslovci
.tmp.cs.premyslovci : Makefile *.sql
	@psql  $(SQLTUTOR_DATABASE) < premyslovci.sql
	@echo  $(SQL) | psql $(SQLTUTOR_DATABASE) 
	@touch $@
