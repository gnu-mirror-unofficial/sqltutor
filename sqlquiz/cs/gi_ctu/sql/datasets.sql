-- DELETE FROM datasets;

SET search_path TO sqltutor;

INSERT INTO datasets VALUES ('odsl', 1, 'pracoviste',  'kod, popis');
INSERT INTO datasets VALUES ('odsl', 2, 'zamestnanci', 'id, jmeno, prijmeni, pracoviste_kod, vek');
INSERT INTO datasets VALUES ('odsl', 3, 'mzdy', 'id, vlozeno, zamestnanec_id, castka');

INSERT INTO datasets VALUES ('filmy', 1, 'filmy',    'id, rok, titul');
INSERT INTO datasets VALUES ('filmy', 2, 'umelci',   'id, jmeno');
INSERT INTO datasets VALUES ('filmy', 3, 'obsazeni', 'film_id, umelec_id, poradi');
INSERT INTO datasets VALUES ('filmy', 4, 'rezie',    'film_id, umelec_id');

INSERT INTO datasets VALUES ('tramvaje', 1, 'zastavky', 'id, zastavka');
INSERT INTO datasets VALUES ('tramvaje', 2, 'linky',    'linka, poradi, zastavka_id');

--     INTO datasets VALUES ('unesco_wh', 1, 'unesco_wh', 'description, category, country, region, inscription, extension');
INSERT INTO datasets VALUES ('unesco', 1, 'unesco', 'pamatka, kategorie, zeme, region, zapis, doplneni');

INSERT INTO datasets VALUES ('staty', 1, 'staty', 'stat, region, populace, hdp');

INSERT INTO datasets VALUES ('letadla', 1, 'dopravni_letadla',    'id, vyrobce, letadlo, dolet_km, kapacita, v_provozu_od');
INSERT INTO datasets VALUES ('letadla', 2, 'letecke_spolecnosti', 'id, spolecnost, zeme, svetadil, aliance, zalozeno');
INSERT INTO datasets VALUES ('letadla', 3, 'letecke_flotily',     'spolecnost_id, letadlo_id, pocet_letadel');

INSERT INTO datasets VALUES ('vodocty', 1, 'toky',      'id, jmeno');
INSERT INTO datasets VALUES ('vodocty', 2, 'stanice',   'id, nazev');
INSERT INTO datasets VALUES ('vodocty', 3, 'vodocty',   'tok_id, stanice_id, cas, vodocet_cm');
INSERT INTO datasets VALUES ('vodocty', 4, 'limity_cm', 'tok_id, stanice_id, bdelost, pohotovost, ohrozeni');
INSERT INTO datasets VALUES ('vodocty', 5, 'cleneni',   'tok_id, stanice_id, kraj, pobocka, povodi');
INSERT INTO datasets VALUES ('premyslovci', 1, 'premyslovci', 'id, jmeno, narozeni, umrti, otec, matka, rod');

