FILES =$(shell ls *.sql)
TABLES=$(shell awk 'toupper($$0) ~ /CREATE.*TABLE/{print $$3 }' $(FILES))

all:
	for f in $(FILES) ; \
	do \
	   echo $$f; \
	   psql $(DBNAME) < $$f; \
	done; \
	for t in $(TABLES); \
	do \
	   echo "REVOKE ALL ON TABLE $$t FROM PUBLIC;   " | psql $(DBNAME); \
	   echo "GRANT SELECT ON TABLE $$t TO PUBLIC;   " | psql $(DBNAME); \
	   echo "GRANT SELECT ON TABLE $$t TO $(DBUSER);" | psql $(DBNAME); \
	done
