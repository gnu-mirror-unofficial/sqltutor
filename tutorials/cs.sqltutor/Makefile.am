CLEANFILES = .tmp.cs.sqltutor
QUIZ_FILES = $(srcdir)/filmy.quiz \
             $(srcdir)/letadla.quiz \
             $(srcdir)/nobel.quiz \
             $(srcdir)/pracoviste.quiz \
             $(srcdir)/premyslovci.quiz \
             $(srcdir)/staty.quiz \
             $(srcdir)/tramvaje.quiz \
             $(srcdir)/unesco.quiz \
             $(srcdir)/vodocty.quiz
EXTRA_DIST = $(QUIZ_FILES)

install: .tmp.cs.sqltutor

.tmp.cs.sqltutor :
	@psql @SQLTUTOR_DATABASE@ -c \
           "SELECT sqltutor.init_tutorial('Czech', 'SQLtutor', 'cs.sqltutor');"
	../.quiz/quiz cs.sqltutor $(QUIZ_FILES) | psql @SQLTUTOR_DATABASE@
	@touch .tmp.cs.sqltutor

