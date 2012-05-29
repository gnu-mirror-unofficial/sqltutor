/*
   This file is part of GNU Sqltutor
   Copyright (C) 2008, 2010, 2012  Free Software Foundation, Inc.
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


/* next question for the given session number
 * ------------------------------------------
 */


CREATE OR REPLACE FUNCTION sqltutor.next_question
(
   IN  session_id_  integer,
   IN  hash_        char(32),

   OUT dataset_id   integer,
   OUT problem_id   integer,
   OUT q_ord        integer,
   OUT language_id  char(2)
)
RETURNS RECORD AS $$
DECLARE
   tutid_     integer;
   pmin_      integer;
   pmax_      integer;
   is_open_   integer;
   algorithm_ integer;
   dataset_   integer;
   problem_   integer;
   q_ord_     integer;
   language_  char(2);
BEGIN
   SELECT tutorial_id, points_min, points_max, ds_id,    is_open,  algorithm
     INTO tutid_,      pmin_,      pmax_,      dataset_, is_open_, algorithm_
     FROM sqltutor.sessions
    WHERE session_id = session_id_
      AND hash_ = md5(cast(start AS text));

   IF is_open_ = 0 THEN
      RETURN;
   END IF;

   IF algorithm_ = 2 THEN
      SELECT q2_dataset_id, q2_problem_id, q2_q_ord, q2_language_id
        INTO dataset_id, problem_id, q_ord, language_id
        FROM sqltutor.next_q2(tutid_, session_id_, pmin_, pmax_, dataset_);
      RETURN;
   ELSE /*1*/
      SELECT q1_dataset_id, q1_problem_id, q1_q_ord, q1_language_id
        INTO dataset_id, problem_id, q_ord, language_id
        FROM sqltutor.next_q1(tutid_, session_id_, pmin_, pmax_, dataset_);
      RETURN;
   END IF;

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.next_q1
(
   IN  tutorial_id_ integer,
   IN  session_id_  integer,
   IN  points_min_  integer,
   IN  points_max_  integer,
   IN  dataset_id_  integer,

   OUT q1_dataset_id  integer,
   OUT q1_problem_id  integer,
   OUT q1_q_ord       integer,
   OUT q1_language_id char(2)
)
RETURNS RECORD AS $$
DECLARE
BEGIN

  SELECT dataset_id, problem_id, q_ord, language_id
    INTO q1_dataset_id, q1_problem_id, q1_q_ord, q1_language_id
    FROM sqltutor.problems
         NATURAL JOIN sqltutor.tutorials_problems
         NATURAL JOIN sqltutor.tutorials
         NATURAL JOIN sqltutor.questions
         NATURAL JOIN sqltutor.answers
   WHERE tutorial_id = tutorial_id_
     AND (dataset_id_ IS NULL OR dataset_id = dataset_id_)
     AND (points_min_ = 0 OR points_min_ <= points)
     AND (points_max_ = 0 OR points_max_ >= points)
     AND problem_id NOT IN (SELECT problem_id
                              FROM sqltutor.sessions_questions
                             WHERE session_id = session_id_)
   ORDER BY random()
   LIMIT 1;

   END;
   $$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.next_q2
(
   IN  tutorial_id_ integer,
   IN  session_id_  integer,
   IN  points_min_  integer,
   IN  points_max_  integer,
   IN  dataset_id_  integer,

   OUT q2_dataset_id   integer,
   OUT q2_problem_id   integer,
   OUT q2_q_ord        integer,
   OUT q2_language_id  char(2)
)
RETURNS RECORD AS $$
DECLARE
   point_splitter   integer = 8;
   questions_asked  integer;
   selected_dataset integer;
BEGIN

   /* the number of questions asked in the current session */
   SELECT count(*) INTO questions_asked
   FROM           sqltutor.sessions_questions
   WHERE  session_id = session_id_;

   IF questions_asked < point_splitter THEN
      SELECT q1_dataset_id, q1_problem_id, q1_q_ord, q1_language_id
        INTO q2_dataset_id, q2_problem_id, q2_q_ord, q2_language_id
        FROM sqltutor.next_q1(tutorial_id_,session_id_,
                questions_asked,questions_asked+point_splitter,NULL);

      IF q2_dataset_id IS NOT NULL THEN
         RETURN;
      END IF;
   END IF;      -- end of opening simple questions' section (test opening)


   /* select a datasets with least number of used questions/problems */

   SELECT available_datasets.dataset_id INTO selected_dataset
   FROM   (
             SELECT DISTINCT dataset_id
             FROM   sqltutor.tutorials_problems
                    NATURAL JOIN sqltutor.problems
             WHERE  tutorial_id = tutorial_id_
             AND    points >= point_splitter
             AND    (dataset_id, problem_id) NOT IN
                     (
                        SELECT dataset_id, problem_id
                        FROM   sqltutor.sessions_questions
                        WHERE  session_id = session_id_
                     )
          ) AS available_datasets
          NATURAL LEFT JOIN
          (
             SELECT dataset_id, problem_id
             FROM   sqltutor.sessions_questions
                    NATURAL JOIN sqltutor.problems
             WHERE  session_id = session_id_
             AND    points >= point_splitter
          ) AS questions_asked
   GROUP BY dataset_id
   ORDER BY count(problem_id), random()
   LIMIT 1;

   /* get a queastion from the selected dataset */
   IF selected_dataset IS NOT NULL THEN
      SELECT q1_dataset_id, q1_problem_id, q1_q_ord, q1_language_id
        INTO q2_dataset_id, q2_problem_id, q2_q_ord, q2_language_id
        FROM sqltutor.next_q1(tutorial_id_,session_id_,point_splitter,0,
                selected_dataset);
   END IF;

   /* try random selection if everything fails */
   IF q2_dataset_id IS NULL THEN
      SELECT q1_dataset_id, q1_problem_id, q1_q_ord, q1_language_id
        INTO q2_dataset_id, q2_problem_id, q2_q_ord, q2_language_id
        FROM sqltutor.next_q1(tutorial_id_,session_id_,0,0,NULL);
   END IF;

   RETURN;

END;
$$ LANGUAGE plpgsql;
