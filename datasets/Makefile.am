EXTRA_DIST = cs.filmy/filmy.sql \
             cs.filmy/Makefile \
             cs.letadla/ciselnik_letadel.sql \
             cs.letadla/dopravni_letadla.sql \
             cs.letadla/letecke_spolecnosti.sql \
             cs.letadla/Makefile \
             cs.pracoviste/Makefile \
             cs.pracoviste/pracoviste.sql \
             cs.premyslovci/Makefile \
             cs.premyslovci/premyslovci.sql \
             cs.staty/Makefile \
             cs.staty/staty.sql \
             cs.tramvaje/Makefile \
             cs.tramvaje/tramvaje.sql \
             cs.unesco/Makefile \
             cs.unesco/unesco.sql \
             cs.unesco/unesco_wh.sql \
             cs.vodocty/Makefile \
             cs.vodocty/vodocty.sql \
             en.bbc/bbc.sql \
             en.bbc/Makefile \
             en.countries/countries.sql \
             en.countries/country_codes.sql \
             en.countries/Makefile \
             en.countries/national_capitals.sql \
             en.countries/table_tennis.sql \
             en.countries/un_regions.sql \
             en.nobel/nobel.sql \
             en.nobel/Makefile

export SQLTUTOR_DATABASE=@SQLTUTOR_DATABASE@
export SQLTUTOR_WWW_USER=@SQLTUTOR_WWW_USER@
export DIRS=$(shell rm -f .tmp.* && ls -l | grep -v CVS | awk '/^d/{print ".tmp."$$8}')


all: 

install: $(DIRS)
.tmp.% : export DATASET=$*
.tmp.% : 
	$(MAKE) -C $(DATASET)

clean:
	@for t in $(shell echo $(DIRS) | sed s/.tmp.//g ); \
	do \
		rm -f $$t/.tmp.* ; \
	done;
