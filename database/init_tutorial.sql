CREATE OR REPLACE FUNCTION sqltutor.init_tutorial(language_ varchar(20),
                                                  tutorial_ varchar(20),
                                                  label_    varchar(12))
RETURNS int
AS $$
DECLARE 
   tid int;
BEGIN
   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials WHERE label=label_;     

   DELETE FROM sqltutor.sessions_answers     WHERE tutorial_id = tid;
   DELETE FROM sqltutor.sessions             WHERE tutorial_id = tid;
   DELETE FROM sqltutor.questions_categories WHERE tutorial_id = tid;
   DELETE FROM sqltutor.answers              WHERE tutorial_id = tid;
   DELETE FROM sqltutor.questions            WHERE tutorial_id = tid;
   DELETE FROM sqltutor.tutorials            WHERE label = label_;

   INSERT INTO sqltutor.tutorials ( language,  tutorial,  label  ) 
                           VALUES ( language_, tutorial_, label_ );

   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials WHERE label=label_;

   return tid;
END
$$ LANGUAGE plpgsql;

