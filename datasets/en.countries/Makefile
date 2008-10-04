SQL = \
" SET search_path TO sqltutor; " \
" DELETE FROM datasets WHERE dataset='countries'; " \
" DELETE FROM dataset_sources WHERE dataset='countries'; " \
" INSERT INTO dataset_sources VALUES('countries', 2008, 'http://wikipedia.org/'); " \
" INSERT INTO datasets VALUES ('countries', 1, 'country_codes', 'a2, a3, num, name'); " \
" INSERT INTO datasets VALUES ('countries', 2, 'un_regions', 'region, name'); " \
" INSERT INTO datasets VALUES ('countries', 3, 'un_regions_countries', 'region, country'); " \
" INSERT INTO datasets VALUES ('countries', 4, 'national_capitals', 'coutry, city, population, area'); " \
" REVOKE ALL   ON TABLE country_codes FROM PUBLIC; " \
" GRANT SELECT ON TABLE country_codes TO PUBLIC; " \
" REVOKE ALL   ON TABLE un_regions FROM PUBLIC; " \
" GRANT SELECT ON TABLE un_regions TO PUBLIC; " \
" REVOKE ALL   ON TABLE un_regions_countries FROM PUBLIC; " \
" GRANT SELECT ON TABLE un_regions_countries TO PUBLIC; " \
" REVOKE ALL   ON TABLE national_capitals FROM PUBLIC; " \
" GRANT SELECT ON TABLE national_capitals TO PUBLIC; " \
" " \
" DELETE FROM datasets WHERE dataset='table_tennis'; " \
" DELETE FROM dataset_sources WHERE dataset='table_tennis'; " \
" INSERT INTO dataset_sources VALUES('table_tennis', 2008, 'sqltutor'); " \
" INSERT INTO datasets VALUES ('table_tennis', 1, 'country', 'id, name'); " \
" INSERT INTO datasets VALUES ('table_tennis', 2, 'ttms', 'games, color, who, country'); " \
" INSERT INTO datasets VALUES ('table_tennis', 3, 'ttws', 'games, color, who, country'); " \
" REVOKE ALL   ON TABLE country FROM PUBLIC; " \
" GRANT SELECT ON TABLE country TO PUBLIC; " \
" REVOKE ALL   ON TABLE ttms FROM PUBLIC; " \
" GRANT SELECT ON TABLE ttms TO PUBLIC; " \
" REVOKE ALL   ON TABLE ttws FROM PUBLIC; " \
" GRANT SELECT ON TABLE ttws TO PUBLIC; " 


all : .tmp.en.countries
.tmp.en.countries : Makefile *.sql
	@cat  countries.sql \
	      country_codes.sql \
	      uk_regions.sql \
	      national_capitals.sql | psql $(SQLTUTOR_DATABASE) 
	@psql $(SQLTUTOR_DATABASE) -f table_tennis.sql
	@echo $(SQL) | psql $(SQLTUTOR_DATABASE)
	@touch $@
