CREATE TABLE sqltutor.tutorials (
   tutorial_id serial PRIMARY KEY,
   language    varchar(20),
   tutorial    varchar(20),
   label       varchar(12) UNIQUE,
   ord         integer DEFAULT 0
);


CREATE TABLE sqltutor.sessions (
   session_id  serial  PRIMARY KEY,
   tutorial_id integer REFERENCES sqltutor.tutorials,
   login       varchar(20),
   password    varchar(20),
   points_min  integer,
   points_max  integer,
   dataset     varchar(12),
   help        boolean NOT NULL DEFAULT false,
   host        inet,
   time        timestamp,
   status      varchar(6) NOT NULL DEFAULT 'open' 
               CHECK (status IN ('open', 'closed'))
);


CREATE TABLE sqltutor.questions (
   tutorial_id  integer REFERENCES sqltutor.tutorials(tutorial_id),
   id           integer,
   dataset      VARCHAR(20),
   points       integer,
   question     TEXT,
   PRIMARY KEY (tutorial_id, id)
);


CREATE TABLE sqltutor.sessions_answers (
   session_id  integer REFERENCES sqltutor.sessions,
   tutorial_id integer, 
   question_id integer,
   answer      text,
   correct     boolean DEFAULT false,
   time        timestamp,
   PRIMARY KEY (session_id, tutorial_id, question_id),
   FOREIGN KEY (tutorial_id, question_id) 
               REFERENCES
               sqltutor.questions(tutorial_id, id)
);



CREATE TABLE sqltutor.answers (
   tutorial_id  integer,
   question_id  integer,
   priority     integer,
   answer       TEXT,
   PRIMARY KEY (tutorial_id, question_id, priority),
   FOREIGN KEY (tutorial_id, question_id) 
               REFERENCES
               sqltutor.questions(tutorial_id, id)
);


CREATE TABLE sqltutor.categories (
   id        integer,
   category  VARCHAR(20),
   UNIQUE (id, category)
);


CREATE TABLE sqltutor.questions_categories (
   tutorial_id  integer,
   question_id  integer,
   category_id  integer NOT NULL,
   PRIMARY KEY (question_id, category_id),
   FOREIGN KEY (tutorial_id, question_id)
               REFERENCES
               sqltutor.questions(tutorial_id, id)
);


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

