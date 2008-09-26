SELECT="SELECT tutorial_id FROM sqltutor.tutorials WHERE label='$(TUTORIAL)'"
INSERT="INSERT INTO sqltutor.tutorials (language, tutorial, label) " \
       "     VALUES             ('English','SQLzoo', 'en.sqlzoo'); "


all: .tmp.$(TUTORIAL)

.tmp.$(TUTORIAL) : Makefile 
	@echo --------- $(TUTORIAL)
	@sed s/zzzzzz/$(TUTORIAL)/g ../delete.sed | psql $(SQLTUTORDB)
	@echo  $(INSERT) | psql $(SQLTUTORDB)
	@echo  $(SELECT) | psql $(SQLTUTORDB) -t | ../.quiz/quiz *.quiz | \
			psql $(SQLTUTORDB)
	@touch $@


