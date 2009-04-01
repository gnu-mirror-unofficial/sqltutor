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


CREATE OR REPLACE FUNCTION sqltutor.init_tutorial(language_ varchar(20),
                                                  tutorial_ varchar(20),
                                                  label_    varchar(12))
RETURNS int
AS $$
DECLARE 
   tid int;
BEGIN
   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials WHERE label=label_;     

   DELETE FROM sqltutor.sessions_answers     WHERE tutorial_id = tid;
   DELETE FROM sqltutor.sessions             WHERE tutorial_id = tid;
   DELETE FROM sqltutor.questions_categories WHERE tutorial_id = tid;
   DELETE FROM sqltutor.answers              WHERE tutorial_id = tid;
   DELETE FROM sqltutor.questions            WHERE tutorial_id = tid;
   DELETE FROM sqltutor.tutorials            WHERE label = label_;

   INSERT INTO sqltutor.tutorials ( language,  tutorial,  label  ) 
                           VALUES ( language_, tutorial_, label_ );

   SELECT tutorial_id INTO tid 
     FROM sqltutor.tutorials WHERE label=label_;

   return tid;
END
$$ LANGUAGE plpgsql;

