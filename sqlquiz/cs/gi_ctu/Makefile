export DATE  =$(shell date -I)
export ARCH  =sqlquiz-$(DATE).tar.gz
export DBNAME=sqlquiz
export DBUSER=wwwquiz
export TUTOR =../../../sqltutor/sql

FILES =$(shell find . -name Makefile)
FILES+=$(shell find . -name *.py)
FILES+=$(shell find . -name *.sql)
FILES+=$(shell find . -name *.xml)
FILES+=$(shell find . -name *.txt)
FILES+=$(shell find . -name *.sed)
FILES+=$(shell find . -name *.sh)
FILES+=$(shell find . -name *.cpp)
FILES+=$(shell find . -name *.quiz)

all:
#	make sqltutor
#	make voidsets
	make datasets
	make quiz_tables
	make privileges
	make questions_and_answers

sqltutor:
	(cd  $(TUTOR) && ./create-tables.sh )

voidsets:
	(cd void && make)

datasets:
	(cd data && make)

quiz_tables:
	psql $(DBNAME) < sql/datasets.sql
	psql $(DBNAME) < sql/dataset_sources.sql

questions_and_answers:
	(cd quiz &&  make && \
	psql $(DBNAME) -t -c \
	"select tutorial_id from sqltutor.tutorials where label='cs.sqltutor'"\
	| ./quiz  *.quiz | psql $(DBNAME) )
#
	@echo \
"SELECT dataset AS \" \", questions, answers" \
"  FROM (SELECT 1 AS zzz, dataset,"  \
"                 count(distinct id) AS questions, count(question_id) AS answers" \
"          FROM sqltutor.questions" \
"               RIGHT JOIN" \
"               sqltutor.answers" \
"               ON id=question_id" \
"         GROUP BY dataset" \
"         UNION ALL" \
"        SELECT '2' AS zzz, 'celkem' AS dataset," \
"               count(distinct id) AS questions, count(question_id) AS answers" \
"          FROM sqltutor.questions" \
"               RIGHT JOIN" \
"               sqltutor.answers" \
"               ON id=question_id) prehled" \
" ORDER BY zzz, dataset;" | psql $(DBNAME)

privileges:
	@for t in `echo "select ds_table from sqltutor.datasets;" | psql $(DBNAME) -t`; \
	do \
	   echo REVOKE ALL   ON TABLE sqltutor.$$t FROM PUBLIC ";" \
		GRANT SELECT ON TABLE sqltutor.$$t TO PUBLIC ";" \
	        GRANT SELECT ON TABLE sqltutor.$$t TO $(DBUSER) ";" | psql $(DBNAME); \
	done
	@for t in sqltutor.datasets sqltutor.dataset_sources; \
	do \
	   echo REVOKE ALL   ON TABLE $$t FROM PUBLIC ";" \
		GRANT SELECT ON TABLE $$t TO PUBLIC ";" \
	        GRANT SELECT ON TABLE $$t TO $(DBUSER) ";" | psql $(DBNAME); \
	done

dump-sessions:
	pg_dump $(DBNAME) --data-only --table=sqltutor.sessions > sessions-$(DATE)
	pg_dump $(DBNAME) --data-only --table=sqltutor.sessions_answers > sessions_answers-$(DATE)

archive:
	tar czvf $(ARCH) $(FILES)

clean:
	rm -rf `find . | grep \~$$`

