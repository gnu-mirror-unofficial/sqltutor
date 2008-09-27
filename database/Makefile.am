EXTRA_DIST = create-database.sh \
             sqltutor.sql \
             merge_category.sql \
             next_question.sql \
             open_session.sql

export SQLTUTOR_DATABASE=@SQLTUTOR_DATABASE@
export SQLTUTOR_WWW_USER=@SQLTUTOR_WWW_USER@

all: install

install:
	@echo
	@echo export SQLTUTOR_DATABASE=@SQLTUTOR_DATABASE@
	@echo export SQLTUTOR_WWW_USER=@SQLTUTOR_WWW_USER@
	@echo $(SHELL) create-database.sh
	@echo
