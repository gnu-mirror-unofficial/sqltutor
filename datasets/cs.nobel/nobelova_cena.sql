DROP   VIEW sqltutor.nobelova_cena;
CREATE VIEW sqltutor.nobelova_cena (rok, obor, nositel)
AS
SELECT yr, CASE subject
              WHEN 'Chemistry'  THEN 'Chemie'
              WHEN 'Economics'  THEN 'Ekomonie'
              WHEN 'Literature' THEN 'Literatura'
              WHEN 'Medicine'   THEN 'Medicína'
              WHEN 'Peace'      THEN 'Mír'
              WHEN 'Physics'    THEN 'Fyzika'
              ELSE subject
           END,
       winner
  FROM sqltutor.nobel;
