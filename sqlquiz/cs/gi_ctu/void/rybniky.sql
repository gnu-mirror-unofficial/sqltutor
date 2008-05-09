-- http://cs.wikipedia.org/wiki/Seznam_%C4%8Desk%C3%BDch_rybn%C3%ADk%C5%AF

DROP TABLE rybniky CASCADE;
CREATE TABLE rybniky (
    rybnik  VARCHAR(20),
    okres   VARCHAR(30),
    rozloha_ha REAL,
    hloubka_m  REAL,
    nadm_vyska REAL,
    odtok      VARCHAR(25),
    povodi     VARCHAR(26)
);


INSERT INTO rybniky VALUES ('Rožmberk',           'Jindřichův Hradec', 489,   6.2,    427, 'Lužnice a Potěšilka', 'Lužnice'  );
INSERT INTO rybniky VALUES ('Horusický rybník',   'Tábor',             416,   6.0,    416, 'Zlatá stoka',         'Lužnice'  );
INSERT INTO rybniky VALUES ('Bezdrev',            'České Budějovice',  394,   7.0,    381, 'Netolický potok',     'Vltava'   );
INSERT INTO rybniky VALUES ('Dvořiště',           'České Budějovice',  337,   4.5,    437, 'Zlatá stoka',         'Lužnice'  );
INSERT INTO rybniky VALUES ('Velký Tisý',         'Jindřichův Hradec', 317,   3.4,    421, 'Zlatá stoka',         'Lužnice'  );
INSERT INTO rybniky VALUES ('Záblatský rybník',   'Jindřichův Hradec', 305,   3.0,    427, 'Zlatá stoka',         'Lužnice'  );
INSERT INTO rybniky VALUES ('Nesyt',              'Břeclav',           296,   3.0,    175, 'Včelínek',            'Dyje'     );
INSERT INTO rybniky VALUES ('Máchovo jezero',     'Česká Lípa',        284,  12.0,    266, 'Robečský potok',      'Ploučnice');
INSERT INTO rybniky VALUES ('Žehuňský rybník',    'Nymburk',           258,   6.0,    204, 'Cidlina',             'Labe'     );
INSERT INTO rybniky VALUES ('Dehtář',             'České Budějovice',  246,   6.0,    406, 'Dehtářský potok',     'Vltava'   );
INSERT INTO rybniky VALUES ('Staňkovský rybník',  'Jindřichův Hradec', 241,   8.5,    469, 'Koštěnický potok',    'Lužnice'  );
INSERT INTO rybniky VALUES ('Velká Holná',        'Jindřichův Hradec', 230,   3.0,    453, 'Holenský potok',      'Nežárka'  );
INSERT INTO rybniky VALUES ('Velké Dářko',        'Žďár nad Sázavou',  205,   3.0,    614, 'Sázava',              'Vltava'   );
INSERT INTO rybniky VALUES ('Svět',               'Jindřichův Hradec', 201,   3.0,    436, 'Spolský potok',       'Lužnice'  );
INSERT INTO rybniky VALUES ('Kačležský rybník',   'Jindřichův Hradec', 196,   2.0,    530, 'Koštěnický potok',    'Lužnice'  );
INSERT INTO rybniky VALUES ('Koclířov',           'Jindřichův Hradec', 192,  NULL,   NULL, 'Zlatá stoka',         'Lužnice'  );
INSERT INTO rybniky VALUES ('Opatovický rybník',  'Jindřichův Hradec', 161,   3.0,    436, 'Zlatá stoka',         'Lužnice'  );
INSERT INTO rybniky VALUES ('Bohdanečský rybník', 'Pardubice',         160,   2.0,    218, 'Opatovický kanál',    'Labe'     );

