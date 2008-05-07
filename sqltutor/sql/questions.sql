DROP TABLE questions CASCADE;
CREATE TABLE questions (
   id        INT PRIMARY KEY,
   dataset   VARCHAR(20),
   points    INT,
   question  TEXT
);

DROP TABLE answers CASCADE;
CREATE TABLE answers (
   question_id  INT REFERENCES questions(id),
   priority     INT,
   answer       TEXT,
   PRIMARY KEY (question_id, priority)
);

DROP TABLE categories CASCADE;
CREATE TABLE categories (
   id        INT,
   category  VARCHAR(20),
   UNIQUE (id, category)
);

DROP TABLE questions_categories CASCADE;
CREATE TABLE questions_categories (
   question_id  INT REFERENCES questions (id),
   category_id  INT NOT NULL,
   PRIMARY KEY (question_id, category_id)
);

CREATE OR REPLACE FUNCTION merge_category(IN question_id_ INT,
                                          IN category_    VARCHAR(20))
RETURNS VOID AS $$ 
DECLARE
   category_id_ INT = NULL;
   tmp_         INT = NULL;
BEGIN
   SELECT INTO category_id_ id FROM categories WHERE category=category_;
   IF category_id_ IS NULL THEN
      BEGIN
         SELECT INTO category_id_ MAX(id) FROM categories;
         IF category_id_ IS NULL THEN
            category_id_ := 0;
         END IF;
         category_id_ := category_id_ + 1;
         INSERT INTO categories VALUES (category_id_, category_);      
      END;
   END IF;
   SELECT INTO tmp_ category_id
     FROM questions_categories
    WHERE question_id = question_id_
          AND category_id = category_id_;
   IF tmp_ IS NULL THEN
      INSERT INTO questions_categories VALUES (question_id_, category_id_);
   END IF;
END;
$$ LANGUAGE plpgsql;

