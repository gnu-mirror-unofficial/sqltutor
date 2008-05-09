DROP TABLE telefony CASCADE;
CREATE TABLE telefony (
   jmeno    VARCHAR(30),
   prijmeni VARCHAR(30),
   do_prace VARCHAR(30),
   domu     VARCHAR(30),
   mobil    VARCHAR(30)
);

INSERT INTO telefony VALUES ('Rudolf',   'Cvach', '233 533 233', '543 333 234', '753 344 228');
INSERT INTO telefony VALUES (   'Jan', 'Valenta', '455 313 822', '543 325 234',         NULL );
INSERT INTO telefony VALUES ( 'Karel',  'Kulich',         NULL , '662 952 847', '248 826 932');
INSERT INTO telefony VALUES (  'Petr',   'Zeman',         NULL ,         NULL , '888 436 962');
