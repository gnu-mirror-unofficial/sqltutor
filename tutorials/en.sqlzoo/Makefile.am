CLEANFILES = .tmp.en.sqlzoo
QUIZ_FILES = $(srcdir)/bbc.quiz \
             $(srcdir)/movies.quiz \
             $(srcdir)/nobel.quiz \
             $(srcdir)/table_tennis.quiz
EXTRA_DIST = $(QUIZ_FILES)

install: .tmp.en.sqlzoo

.tmp.en.sqlzoo :
	@psql @SQLTUTOR_DATABASE@ -c \
           "SELECT sqltutor.init_tutorial('English', 'SQLzoo', 'en.sqlzoo');"
	../.quiz/quiz en.sqlzoo $(QUIZ_FILES) | psql @SQLTUTOR_DATABASE@
	@touch .tmp.en.sqlzoo

