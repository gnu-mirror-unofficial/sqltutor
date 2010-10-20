/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008, 2010  Free Software Foundation, Inc.
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


CREATE OR REPLACE FUNCTION sqltutor.init_tutorial
(
   language_id_ varchar(2),
   tutorial_    varchar(40)
)
RETURNS integer
AS $$
DECLARE 
   tid integer;
   sid integer;
BEGIN
   PERFORM sqltutor.delete_tutorial(language_id_, tutorial_);

   INSERT INTO sqltutor.tutorials (language_id,  tutorial ) 
                           VALUES (language_id_, tutorial_);

   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials 
    WHERE language_id = language_id_ 
      AND tutorial    = tutorial_;     

   return tid;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.delete_tutorial
(
   language_id_ varchar(2),
   tutorial_    varchar(40)
)
RETURNS void
AS $$
DECLARE 
   tid integer;
BEGIN
   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials 
    WHERE language_id = language_id_ 
      AND tutorial    = tutorial_;     

   DELETE FROM sqltutor.sessions_questions
         WHERE session_id  IN  ( SELECT session_id
                                   FROM sqltutor.sessions 
                                  WHERE tutorial_id = tid );
   DELETE FROM sqltutor.tutorials_problems
                                  WHERE tutorial_id = tid;
   DELETE FROM sqltutor.sessions  WHERE tutorial_id = tid;
   DELETE FROM sqltutor.tutorials WHERE tutorial_id = tid;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sqltutor.insert_dataset
(
   tutorial_    varchar(40),
   language_id_ char(2),
   dataset_     varchar(40)
)
RETURNS varchar(90)
AS $$
DECLARE 
   tut integer;
   dat integer;
BEGIN
   SELECT tutorial_id INTO tut 
     FROM sqltutor.tutorials 
    WHERE tutorial = tutorial_ 
      AND language_id = language_id_;

   SELECT dataset_id INTO dat 
     FROM sqltutor.datasets
    WHERE dataset = dataset_;

   INSERT INTO sqltutor.tutorials_problems
          SELECT DISTINCT tut, dat, problem_id
            FROM sqltutor.problems
                 NATURAL JOIN sqltutor.questions
                 NATURAL JOIN sqltutor.datasets
           WHERE dataset_id  = dat
             AND language_id = language_id_;

   RETURN tutorial_ || ' ' || language_id_ || ' ' || dataset_;
END
$$ LANGUAGE plpgsql;


