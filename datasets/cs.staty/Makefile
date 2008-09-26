SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='staty'; " \
" DELETE FROM dataset_sources WHERE dataset='staty'; " \
" INSERT INTO dataset_sources VALUES('staty', 2006, 'http://unstats.un.org/unsd/demographic/products/socind/inc-eco.htm'); " \
" INSERT INTO datasets VALUES ('staty', 1, 'staty', 'stat, region, populace, hdp'); " \
" REVOKE ALL   ON TABLE staty    FROM PUBLIC; " \
" GRANT SELECT ON TABLE staty    TO PUBLIC; "


all : .tmp.cs.staty
.tmp.cs.staty : Makefile *.sql
	@psql  $(SQLTUTORDB) < staty.sql
	@echo  $(SQL) | psql $(SQLTUTORDB) 
	@touch $@
