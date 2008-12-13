CLEANFILES = lock..en.movies
EXTRA_DIST = movies.sql

all :

install : lock..en.movies

lock..en.movies :
	-psql @SQLTUTOR_DATABASE@ < $(srcdir)/movies.sql
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.init_dataset('movies', 2008, 'http://sqlzoo.net/')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('movies', 1, 'actor',   'id, name')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('movies', 2, 'movie',   'id, title, yr, score, votes, director')"
	@psql @SQLTUTOR_DATABASE@ -c "SELECT sqltutor.add_ds_table('movies', 3, 'casting', 'movieid, actorid, ord')"
	@touch $@
