CLEANFILES = lock..cs.sqltutor
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

install: lock..cs.sqltutor

lock..cs.sqltutor :
	@psql @SQLTUTOR_DATABASE@ -c \
           "SELECT sqltutor.init_tutorial('Czech', 'SQLtutor', 'cs.sqltutor');"
	../.quiz/quiz cs.sqltutor $(QUIZ_FILES) | psql @SQLTUTOR_DATABASE@
	@touch lock..cs.sqltutor

