# Each tutorial must be defined in a separate directory with Makefile
# that deletes all records dependend on the tutorial label (see script
# delete.sed) and runs INSERT like the following
#
#    INSERT INTO sqltutor.tutorials (language, tutorial, label)
#                VALUES             ('English','SQLzoo', 'en.sqlzoo');
#
# Name of the tutorial directory must correspond to its label,
# 'en.sqlzoo.sql' for the example above.
#
# Tutorial label is passed to subdirectories as the environment
# variable TUTORIAL
#
#
EXTRA_DIST = delete.sed \
             cs.sqltutor/Makefile \
             cs.sqltutor/filmy.quiz \
             cs.sqltutor/letadla.quiz \
             cs.sqltutor/pracoviste.quiz \
             cs.sqltutor/premyslovci.quiz \
             cs.sqltutor/staty.quiz \
             cs.sqltutor/tramvaje.quiz \
             cs.sqltutor/unesco.quiz \
             cs.sqltutor/vodocty.quiz \
             en.sqlzoo/Makefile \
             en.sqlzoo/bbc.quiz
SUBDIRS    = .quiz

export SQLTUTOR_DATABASE=@SQLTUTOR_DATABASE@
export DIRS=$(shell rm -f .tmp.* && ls -l | grep -v CVS | awk '/^d/{print ".tmp."$$8}')


all:

install: .quiz/quiz $(DIRS)

.tmp.% : export TUTORIAL=$*
.tmp.% :
	@$(MAKE) -C $(TUTORIAL)

.quiz/quiz : .quiz/quiz.cpp .quiz/Makefile
	$(MAKE) -C .quiz


clean:
	@for t in $(shell echo $(DIRS) | sed s/.tmp.//g ); \
	do \
		rm -f $$t/.tmp.* ; \
	done;
