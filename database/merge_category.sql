CREATE OR REPLACE FUNCTION sqltutor.merge_category
(
   IN tutorial_id_ integer,
   IN question_id_ integer,
   IN category_    VARCHAR(20)
)
RETURNS VOID AS $$ 
DECLARE
   category_id_ integer = NULL;
   tmp_         integer = NULL;
BEGIN
   SELECT INTO category_id_ id 
    FROM sqltutor.categories 
   WHERE category=category_;

   IF category_id_ IS NULL THEN
      BEGIN
         SELECT INTO category_id_ MAX(id) FROM sqltutor.categories;
         IF category_id_ IS NULL THEN
            category_id_ := 0;
         END IF;
         category_id_ := category_id_ + 1;
         INSERT INTO sqltutor.categories VALUES (category_id_, category_);     
      END;
   END IF;

   SELECT INTO tmp_ category_id
     FROM sqltutor.questions_categories
    WHERE tutorial_id = tutorial_id_
      AND question_id = question_id_
      AND category_id = category_id_;

   IF tmp_ IS NULL THEN
      INSERT INTO sqltutor.questions_categories 
             VALUES (tutorial_id_, question_id_, category_id_);
   END IF;
END;
$$ LANGUAGE plpgsql;
