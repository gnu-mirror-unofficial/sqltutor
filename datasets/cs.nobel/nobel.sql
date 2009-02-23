/* 
   This file is public domain.

   The data is a matter of public record, and comes from
   http://www.gnu.org/software/sqltutor   
 */


DROP   VIEW sqltutor.laureati;
CREATE VIEW sqltutor.laureati (rok, obor, laureat)
AS
SELECT year, CASE subject
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
