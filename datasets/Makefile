export SQLTUTORDB=sqlquiz
export WEBSQLTUTOR=wwwquiz
DIRS=$(shell rm -f .tmp.* && ls -l | grep -v CVS | awk '/^d/{print ".tmp."$$8}')


all: $(DIRS)

.tmp.% : export DATASET=$*
.tmp.% : 
	$(MAKE) -C $(DATASET)

clean:
	@for t in $(shell echo $(DIRS) | sed s/.tmp.//g ); \
	do \
		rm -f $$t/.tmp.* ; \
	done;
