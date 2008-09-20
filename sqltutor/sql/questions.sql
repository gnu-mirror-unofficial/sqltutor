CREATE TABLE sqltutor.questions (
   id          integer PRIMARY KEY,
   tutorial_id integer,           -- REFERENCES sqltutor.tutorials,
   dataset     VARCHAR(20),
   points      integer,
   question    TEXT
);


CREATE TABLE sqltutor.answers (
   question_id  integer REFERENCES sqltutor.questions(id),
   priority     integer,
   answer       TEXT,
   PRIMARY KEY (question_id, priority)
);


CREATE TABLE sqltutor.categories (
   id        integer,
   category  VARCHAR(20),
   UNIQUE (id, category)
);


CREATE TABLE sqltutor.questions_categories (
   question_id  integer REFERENCES sqltutor.questions (id),
   category_id  integer NOT NULL,
   PRIMARY KEY (question_id, category_id)
);


CREATE OR REPLACE FUNCTION sqltutor.merge_category(IN question_id_ integer,
                                                   IN category_    VARCHAR(20))
RETURNS VOID AS $$ 
DECLARE
   category_id_ integer = NULL;
   tmp_         integer = NULL;
BEGIN
   SELECT INTO category_id_ id FROM sqltutor.categories WHERE category=category_;
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
    WHERE question_id = question_id_
          AND category_id = category_id_;
   IF tmp_ IS NULL THEN
      INSERT INTO sqltutor.questions_categories VALUES (question_id_, category_id_);
   END IF;
END;
$$ LANGUAGE plpgsql;

