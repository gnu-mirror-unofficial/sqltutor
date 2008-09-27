SELECT="SELECT tutorial_id FROM sqltutor.tutorials WHERE label='$(TUTORIAL)'"
INSERT="INSERT INTO sqltutor.tutorials (language, tutorial,   label)  " \
       "     VALUES             ('Czech',  'SQLtutor', 'cs.sqltutor');"


all: .tmp.$(TUTORIAL)

.tmp.$(TUTORIAL) :
	@echo  -------- $(TUTORIAL)
	@sed   s/zzzzzz/$(TUTORIAL)/g ../delete.sed | psql $(SQLTUTOR_DATABASE)
	@echo  $(INSERT) | psql $(SQLTUTOR_DATABASE)
	@echo  $(SELECT) | psql $(SQLTUTOR_DATABASE) -t | ../.quiz/quiz *.quiz | \
			psql $(SQLTUTOR_DATABASE)
	@touch $@

