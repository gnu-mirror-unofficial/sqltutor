CLEANFILES = .tmp.en.sqlzoo
EXTRADIST  = bbc.quiz \
             nobel.quiz 

all:

install: .tmp.en.sqlzoo

.tmp.en.sqlzoo : ../.quiz/quiz
	@psql @SQLTUTOR_DATABASE@ -t -c \
           "SELECT sqltutor.init_tutorial('English', 'SQLzoo', 'en.sqlzoo');" \
	   | ../.quiz/quiz *.quiz | psql @SQLTUTOR_DATABASE@
	@touch .tmp.en.sqlzoo

