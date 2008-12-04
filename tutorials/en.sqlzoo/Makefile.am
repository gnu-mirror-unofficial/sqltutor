CLEANFILES = .tmp.en.sqlzoo
EXTRA_DIST = bbc.quiz \
             nobel.quiz \
             movies.quiz

all:

install: .tmp.en.sqlzoo

.tmp.en.sqlzoo : ../.quiz/quiz
	@psql @SQLTUTOR_DATABASE@ -t -c \
           "SELECT sqltutor.init_tutorial('English', 'SQLzoo', 'en.sqlzoo');" \
	   | ../.quiz/quiz $(srcdir)/*.quiz | psql @SQLTUTOR_DATABASE@
	@touch .tmp.en.sqlzoo

