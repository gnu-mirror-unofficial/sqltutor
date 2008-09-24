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
export SQLTUTORDB=sqlquiz
DIRS=$(shell rm -f .tmp.* && ls -l | awk '/^d/{print ".tmp."$$8}')


all: .quiz/quiz $(DIRS)

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
