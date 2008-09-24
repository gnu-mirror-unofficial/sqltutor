BEGIN;

SET search_path TO sqltutor;

DELETE FROM sessions_answers WHERE tutorial_id =
   (SELECT tutorial_id FROM tutorials WHERE label='zzzzzz');

DELETE FROM answers WHERE tutorial_id =
   (SELECT tutorial_id FROM tutorials WHERE label='zzzzzz');

DELETE FROM questions_categories WHERE tutorial_id =
   (SELECT tutorial_id FROM tutorials WHERE label='zzzzzz');

DELETE FROM questions WHERE tutorial_id =
   (SELECT tutorial_id FROM tutorials WHERE label='zzzzzz');

DELETE FROM sessions WHERE tutorial_id =
   (SELECT tutorial_id FROM tutorials WHERE label='zzzzzz');

DELETE FROM tutorials WHERE label='zzzzzz';

COMMIT;
