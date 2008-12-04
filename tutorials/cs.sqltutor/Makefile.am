CLEANFILES = .tmp.cs.sqltutor
EXTRA_DIST = filmy.quiz \
             letadla.quiz \
             pracoviste.quiz \
             premyslovci.quiz \
             staty.quiz \
             tramvaje.quiz \
             unesco.quiz \
             vodocty.quiz

all:

install: .tmp.cs.sqltutor

.tmp.cs.sqltutor : ../.quiz/quiz
	@psql @SQLTUTOR_DATABASE@ -t -c \
           "SELECT sqltutor.init_tutorial('Czech', 'SQLtutor', 'cs.sqltutor');" \
	   | ../.quiz/quiz $(srcdir)/*.quiz | psql @SQLTUTOR_DATABASE@
	@touch .tmp.cs.sqltutor

