/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2010  Free Software Foundation, Inc.
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



CREATE OR REPLACE FUNCTION sqltutor.grant_privileges
(
   user_ varchar(40), 
   exec_ varchar(40)
)
RETURNS void AS $$
DECLARE
BEGIN

EXECUTE 'GRANT USAGE ON SCHEMA sqltutor      TO ' || user_ || ', ' || exec_; 
EXECUTE 'GRANT USAGE ON SCHEMA sqltutor_data TO ' || user_ || ', ' || exec_; 

EXECUTE 'REVOKE ALL ON TABLE sqltutor.tutorials           FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.tutorials_problems  FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.datasets            FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.dataset_tables      FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.dataset_sources     FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.problems            FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.answers             FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.questions           FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.problems_categories FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.categories          FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.languages           FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.sessions            FROM PUBLIC, ' || user_ || ', ' || exec_; 
EXECUTE 'REVOKE ALL ON TABLE sqltutor.sessions_questions  FROM PUBLIC, ' || user_ || ', ' || exec_; 

EXECUTE 'GRANT SELECT ON TABLE sqltutor.tutorials           TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.tutorials_problems  TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.datasets            TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.dataset_tables      TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.dataset_sources     TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.problems            TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.answers             TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.questions           TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.problems_categories TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.categories          TO ' || user_; 
EXECUTE 'GRANT SELECT ON TABLE sqltutor.languages           TO ' || user_; 

EXECUTE 'GRANT INSERT ON TABLE sqltutor.sessions           TO ' || user_;
EXECUTE 'GRANT UPDATE ON TABLE sqltutor.sessions           TO ' || user_;
EXECUTE 'GRANT SELECT ON TABLE sqltutor.sessions           TO ' || user_;
EXECUTE 'GRANT INSERT ON TABLE sqltutor.sessions_questions TO ' || user_;
EXECUTE 'GRANT UPDATE ON TABLE sqltutor.sessions_questions TO ' || user_;
EXECUTE 'GRANT SELECT ON TABLE sqltutor.sessions_questions TO ' || user_;

EXECUTE 'REVOKE ALL ON FUNCTION    sqltutor.next_question(integer, char(32)) FROM PUBLIC';
EXECUTE 'GRANT EXECUTE ON FUNCTION sqltutor.next_question(integer, char(32)) TO ' || user_;

EXECUTE 'REVOKE ALL ON sqltutor.sessions_session_id_seq FROM PUBLIC';
EXECUTE 'GRANT  ALL ON sqltutor.sessions_session_id_seq TO ' || user_;

END;
$$ LANGUAGE plpgsql;

