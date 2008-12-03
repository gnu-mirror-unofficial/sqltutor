CREATE OR REPLACE FUNCTION sqltutor.init_tutorial(planguage varchar(20),
                                                  ptutorial varchar(20),
                                                  plabel    varchar(12))
RETURNS int
AS $$
DECLARE 
   tid int;
BEGIN
   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials WHERE label=plabel;     

   DELETE FROM sqltutor.sessions_answers     WHERE tutorial_id = tid;
   DELETE FROM sqltutor.answers              WHERE tutorial_id = tid;
   DELETE FROM sqltutor.questions_categories WHERE tutorial_id = tid;
   DELETE FROM sqltutor.questions            WHERE tutorial_id = tid;
   DELETE FROM sqltutor.sessions             WHERE tutorial_id = tid;
   DELETE FROM sqltutor.tutorials            WHERE label = plabel;

   INSERT INTO sqltutor.tutorials (  language,  tutorial,  label ) 
                           VALUES ( planguage, ptutorial, plabel );

   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials WHERE label=plabel;     

   return tid;
END
$$ LANGUAGE plpgsql;

