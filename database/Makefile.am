CLEANFILES = .tmp.database
EXTRA_DIST = sqltutor.sql \
             merge_category.sql \
             next_question.sql \
             open_session.sql

all: 

install : .tmp.database

.tmp.database : Makefile *.sql
#
	@echo -e "\ncreating schema"
	@echo -e  "===============\n"
#
	psql @SQLTUTOR_DATABASE@  -c "DROP SCHEMA sqltutor CASCADE;"
	psql @SQLTUTOR_DATABASE@  -c "CREATE SCHEMA sqltutor;"
	psql @SQLTUTOR_DATABASE@  -c "GRANT USAGE ON SCHEMA sqltutor TO @SQLTUTOR_WWW_USER@;"
	psql @SQLTUTOR_DATABASE@  -c "GRANT USAGE ON SCHEMA sqltutor TO @SQLTUTOR_WWW_EXEC@;"
#
	@echo -e "\ncreating tables"
	@echo -e  "===============\n";
#
	psql @SQLTUTOR_DATABASE@ < sqltutor.sql
#
	@echo -e "\ngranting privileges"
	@echo -e   "===================\n"
#
	@for t in answers questions questions_categories categories \
	         datasets dataset_sources ; \
	do \
	   echo REVOKE ALL   ON TABLE sqltutor.$$t FROM PUBLIC ";"  \
	        GRANT SELECT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" | psql @SQLTUTOR_DATABASE@  ; \
	done
#
	@for t in tutorials questions datasets dataset_sources; \
	do \
	   echo GRANT SELECT ON TABLE sqltutor.$$t TO PUBLIC ";" | psql @SQLTUTOR_DATABASE@ ; \
	done 
#
	@for t in sessions sessions_answers ; \
	do \
	   echo REVOKE ALL ON TABLE   sqltutor.$$t FROM PUBLIC ";" \
	        GRANT INSERT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" \
	        GRANT UPDATE ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" \
	        GRANT SELECT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" | psql @SQLTUTOR_DATABASE@ ; \
	done
#
	@for t in sessions_session_id_seq ; \
	do \
	   echo REVOKE ALL ON TABLE   sqltutor.$$t FROM PUBLIC ";" \
	        GRANT UPDATE ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" \
	        GRANT SELECT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" | psql @SQLTUTOR_DATABASE@ ; \
	done
#
	@for t in sessions sessions_answers ; \
	do \
	   echo REVOKE ALL ON TABLE   sqltutor.$$t FROM PUBLIC ";" \
	        GRANT INSERT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" \
	        GRANT UPDATE ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" \
	        GRANT SELECT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" | psql @SQLTUTOR_DATABASE@ ; \
	done
#
	@for t in sessions_session_id_seq ; \
	do \
	   echo REVOKE ALL ON TABLE   sqltutor.$$t FROM PUBLIC ";" \
	        GRANT UPDATE ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" \
	        GRANT SELECT ON TABLE sqltutor.$$t TO @SQLTUTOR_WWW_USER@ ";" | psql @SQLTUTOR_DATABASE@ ; \
	done
#
	@echo -e "\ncreating functions"
	@echo -e   "==================\n"
#
	@for func in $$(ls *.sql | grep -v sqltutor.sql) ; \
	do \
	  psql @SQLTUTOR_DATABASE@ < $$func ; \
	done
# 
	@echo -e "\ngranting privileges"
	@echo -e   "===================\n"
	@echo -e "REVOKE ALL ON FUNCTION sqltutor.next_question(integer, char(32)) FROM PUBLIC;\n" \
	         "GRANT EXECUTE ON FUNCTION sqltutor.next_question(integer, char(32)) TO @SQLTUTOR_WWW_USER@;" \
	         | psql @SQLTUTOR_DATABASE@
# 
	@touch .tmp.database
#
