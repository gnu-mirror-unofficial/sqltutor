CLEANFILES = lock..database
EXTRA_DIST = sqltutor.sql \
             init_tutorial.sql \
             init_dataset.sql \
             merge_category.sql \
             next_question.sql \
             open_session.sql \
             check_password.sql \
             grant_privileges.sql

all: 

install : lock..database

lock..database : Makefile
#
	@echo -e "\ncreating schema"
	@echo -e  "===============\n"
#
#	-psql @SQLTUTOR_DATABASE@ -c "CREATE LANGUAGE plpgsql"
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/sqltutor.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/init_tutorial.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/init_dataset.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/merge_category.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/next_question.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/open_session.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/check_password.sql
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/grant_privileges.sql
	-psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.grant_privileges('@SQLTUTOR_WWW_USER@', '@SQLTUTOR_WWW_EXEC@')"

