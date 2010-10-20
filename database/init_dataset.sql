/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008  Free Software Foundation, Inc.
   Contributed by Ales Cepek <cepek@gnu.org>
 
   GNU Sqltutor is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   GNU Sqltutor is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with GNU Sqltutor.  If not, see <http://www.gnu.org/licenses/>.
 */


CREATE OR REPLACE FUNCTION sqltutor.init_dataset (dsname text)
RETURNS text 
AS $$
DECLARE
   did integer;
BEGIN
   SELECT dataset_id INTO did
     FROM sqltutor.datasets
    WHERE dataset = dsname;  

   DELETE FROM sqltutor.dataset_sources WHERE dataset_id = did; 
   DELETE FROM sqltutor.dataset_tables  WHERE dataset_id = did;

   INSERT INTO sqltutor.datasets (dataset) 
          SELECT dsname
          EXCEPT 
          SELECT dsname FROM sqltutor.datasets WHERE dataset_id = did;

   RETURN dsname;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.add_ds_source (
        dataset_ text,
        year_    int,
        source_  text)
RETURNS void
AS $$
DECLARE
   did integer;
BEGIN
   SELECT dataset_id INTO did
     FROM sqltutor.datasets
    WHERE dataset = dataset_;  
   
    INSERT INTO sqltutor.dataset_sources (dataset_id, year,  source) 
                                  VALUES (did,        year_, source_);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.add_ds_table (
        dataset_  text,
        ord_      int,
        ds_table_ text,
        columns_  text )
RETURNS void
AS $$
DECLARE
   did integer;
BEGIN

   EXECUTE 'GRANT SELECT ON sqltutor_data.' || ds_table_ || ' TO PUBLIC';
   EXECUTE 'SELECT ' || columns_ || ' FROM sqltutor_data.' || ds_table_ || ' LIMIT 1'; 

   SELECT dataset_id INTO did
     FROM sqltutor.datasets
    WHERE dataset = dataset_;  

   INSERT INTO sqltutor.dataset_tables (dataset_id, ds_table,  columns,  dt_ord)
                                VALUES (did,        ds_table_, columns_, ord_);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.insert_problem(
        dataset_    text,
        problem_id_ int,
        points_     int,
        category_   text)
RETURNS void
AS $$
DECLARE
   did_ integer;
   pts_ integer;
BEGIN
   /* categories are not implemented  */

   SELECT dataset_id INTO did_
     FROM sqltutor.datasets
    WHERE dataset = dataset_;  

   SELECT points INTO pts_
     FROM sqltutor.problems
    WHERE dataset_id = did_ AND problem_id = problem_id_;

   IF pts_ IS NOT NULL THEN
      IF points_ <> pts_ THEN
         UPDATE sqltutor.problems SET points = points_
          WHERE dataset_id = did_ AND problem_id = problem_id_;
      END IF;
      RETURN;
   END IF;

   INSERT INTO sqltutor.problems (dataset_id, problem_id,  points)
                          VALUES (did_,       problem_id_, points_);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.insert_question(
        dataset_    text,
        problem_id_ int,
        q_ord_      int,
        lang_       char(2),
        question_   text)
RETURNS void
AS $$
DECLARE
   did_ integer;
   qst_ text;
BEGIN
   SELECT dataset_id INTO did_
     FROM sqltutor.datasets
    WHERE dataset = dataset_;  

   SELECT question INTO qst_
     FROM sqltutor.questions
    WHERE dataset_id  = did_
      AND problem_id  = problem_id_
      AND q_ord       = q_ord_
      AND language_id = lang_;

   IF qst_ IS NOT NULL THEN
      IF question_ <> qst_ THEN
         UPDATE sqltutor.questions SET question = question_
          WHERE dataset_id  = did_
            AND problem_id  = problem_id_
            AND q_ord       = q_ord_
            AND language_id = lang_;
      END IF;
      RETURN;
   END IF;

   INSERT INTO sqltutor.questions
               (dataset_id, problem_id,  q_ord,  language_id, question)
        VALUES (did_,       problem_id_, q_ord_, lang_,       question_);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.insert_answer(
        dataset_    text,
        problem_id_ int,
        priority_   int,
        answer_     text)
RETURNS void
AS $$
DECLARE
   did_ integer;
   ans_ text;
BEGIN
   SELECT dataset_id INTO did_
     FROM sqltutor.datasets
    WHERE dataset = dataset_;  

   SELECT answer INTO ans_
     FROM sqltutor.answers
    WHERE dataset_id  = did_
      AND problem_id  = problem_id_
      AND priority    = priority_;

   IF ans_ IS NOT NULL THEN
      IF answer_ <> ans_ THEN
         UPDATE sqltutor.answers SET answer = answer_
          WHERE dataset_id  = did_
            AND problem_id  = problem_id_
            AND priority    = priority_;
      END IF;
      RETURN;
   END IF;

   INSERT INTO sqltutor.answers(dataset_id, problem_id,  answer,  priority)
                         VALUES(did_,       problem_id_, answer_, priority_);
END
$$ LANGUAGE plpgsql;

