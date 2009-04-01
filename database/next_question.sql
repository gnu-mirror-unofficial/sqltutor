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


/* next question for the given session number
 * ------------------------------------------      
 */


CREATE OR REPLACE FUNCTION sqltutor.next_question
(
   IN  session_id_      integer, 
   IN  hash_            char(32),
   OUT next_tutorial_id integer,
   OUT next_question_id integer
)
AS $$
DECLARE
   s_dataset_     varchar(21);
   s_status_      varchar(6);
   s_points_min_  integer;
   s_points_max_  integer;
   s_help_        boolean;
   max_points_    integer;
   a_count_       integer;
BEGIN
   SELECT tutorial_id, points_min, points_max, dataset, status 
     INTO next_tutorial_id, s_points_min_, s_points_max_, s_dataset_, s_status_
     FROM sqltutor.sessions
    WHERE session_id=session_id_ 
      AND hash_ = md5(cast(time AS text));


   IF s_points_min_ IS NULL AND 
      s_points_max_ IS NULL AND 
      s_dataset_    IS NULL
   THEN
      /* algorithm 2 */

      SELECT coalesce(max(points),1) INTO max_points_
        FROM sqltutor.questions AS q
             JOIN
             sqltutor.sessions_answers AS s
             ON (q.tutorial_id = s.tutorial_id AND q.id = s.question_id)
       WHERE session_id = session_id_;

      IF max_points_ < 5 THEN

         SELECT count(*) INTO a_count_
           FROM sqltutor.questions AS q
                JOIN
                sqltutor.sessions_answers AS s
                ON (q.tutorial_id = s.tutorial_id AND q.id = s.question_id)
          WHERE s.session_id = session_id_
            AND s.correct
            AND q.points = max_points_;
         
         IF a_count_ >= max_points_ THEN
            max_points_ := max_points_ + 1;
         END IF;

         IF max_points_ < 5 THEN
            s_points_min_ := max_points_;  
            
            SELECT id INTO next_question_id
              FROM (SELECT id, points, random() AS rand
                      FROM sqltutor.questions
                     WHERE (tutorial_id = next_tutorial_id) AND
                           (s_points_min_ <= points) AND
                           (s_status_ = 'open') AND
                           (id NOT IN (SELECT question_id 
                                           FROM sqltutor.sessions_answers
                                          WHERE session_id=session_id_))
                     ORDER BY points ASC, rand
                     LIMIT 1) next;
            
            RETURN;
         END IF;
      END IF;

      /* for points >=5 continue with algoritm 1 */
      s_points_min_ := 5;       

   END IF;


   /* algorithm 1 */

   SELECT id INTO next_question_id
     FROM (SELECT q.id, random() AS rand
             FROM sqltutor.questions AS q
            WHERE (next_tutorial_id = tutorial_id) AND 
                  (s_dataset_ IS NULL OR s_dataset_ = q.dataset) AND
                  (s_points_min_ IS NULL OR s_points_min_ <= q.points) AND
                  (s_points_max_ IS NULL OR s_points_max_ >= q.points) AND
                  (s_status_ = 'open') AND
                  (id NOT IN (SELECT question_id 
                                  FROM sqltutor.sessions_answers
                                 WHERE session_id=session_id_))
            ORDER BY rand
            LIMIT 1) next;

   RETURN ;
END;
$$ LANGUAGE plpgsql;
