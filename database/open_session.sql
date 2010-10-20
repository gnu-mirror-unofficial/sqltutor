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


CREATE OR REPLACE FUNCTION sqltutor.open_session
(
      IN  tutorial_id_ integer,
      IN  logint_      text,
      IN  password_    varchar(20),
      IN  points_min_  integer,
      IN  points_max_  integer,
      IN  dataset_     varchar(40),
      IN  help_        integer,
      IN  host_        inet
) 
RETURNS TABLE (session_id_  integer, hash_ char(32))
AS $$
DECLARE
   login_      varchar(20) = cast(logint_ as varchar(20));
   time_       timestamp = now();
   dataset_id_ integer;
   algorithm_  integer   = 1;
   passwd_ok_  integer;
BEGIN

   SELECT sqltutor.check_password(logint_, password_, host_) INTO passwd_ok_;
   IF passwd_ok_ <> 0
   THEN
      RETURN;
   END IF;

   IF points_min_ = 0 AND 
      points_max_ = 0 AND 
      dataset_ IS NULL
   THEN
      algorithm_ = 2;
   END IF;

  SELECT dataset_id INTO dataset_id_
    FROM sqltutor.datasets
   WHERE dataset = dataset_;

   INSERT INTO sqltutor.sessions 
                        (tutorial_id,
                         login,       password,  points_min,  points_max,
                         ds_id,       help,      algorithm,   host,  start) 
                 VALUES (tutorial_id_,
                         login_,      password_, points_min_, points_max_,
                         dataset_id_, help_,     algorithm_,  host_, time_);

   SELECT INTO session_id_ lastval();
   hash_ = md5(cast(time_ AS text));
   RETURN NEXT;

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sqltutor.evaluation
(
        IN  sid           integer,
	OUT ev_total      integer,
        OUT ev_correct    integer,
	OUT ev_points     integer,
        OUT ev_evaluation integer,
	OUT ev_help       integer,
	OUT ev_points_min integer,
        OUT ev_points_max integer,
	OUT ev_login      varchar(20),
        OUT ev_dataset    varchar(40)
) 
AS $$
DECLARE
   total_ integer;
BEGIN
   SELECT help, points_min, points_max, login, dataset
   	  INTO ev_help, ev_points_min, ev_points_max, 
               ev_login, ev_dataset
     FROM sqltutor.sessions
          LEFT JOIN sqltutor.datasets ON (dataset_id=ds_id)
    WHERE session_id = sid;
   SELECT count(*), coalesce(sum(correct),0)
          INTO ev_total, ev_correct
     FROM sqltutor.sessions_questions AS SQ
    WHERE session_id = sid;
   SELECT coalesce(sum(points), 0) INTO ev_points
     FROM sqltutor.sessions_questions
          NATURAL JOIN sqltutor.problems
    WHERE session_id = sid
      AND correct = 1;
   total_ = ev_total;
   IF total_ < 1 THEN 
      total_ = 1;
   END IF;
   SELECT (ev_points*ev_correct) / CASE ev_total WHEN 0 THEN 1 ELSE ev_total 
                                   END 
          INTO ev_evaluation;
END;
$$ LANGUAGE plpgsql;
