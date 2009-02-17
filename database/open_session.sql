/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008  Ales Cepek <cepek@gnu.org>
 
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
      IN  tutorial_ integer,
      IN  login_      varchar(20),
      IN  password_   varchar(20),
      IN  points_min_ integer,
      IN  points_max_ integer,
      IN  dataset_    varchar(21),
      IN  help_       boolean,
      IN  host_       inet,
      OUT session_id_ integer,
      OUT hash_       char(32)
) 
AS $$
DECLARE
   time_ timestamp = now();
BEGIN
   INSERT INTO sqltutor.sessions 
                        (tutorial_id,
                         login,    password,  points_min,  points_max,
                         dataset,  help,      host,        time ) 
                 VALUES (tutorial_,
                         login_,   password_, points_min_, points_max_,
                         dataset_, help_,     host_,       time_);

   SELECT INTO session_id_ lastval();
   hash_ = md5(cast(time_ AS text));
END;
$$ LANGUAGE plpgsql;
