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

/* NOT USED
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
*/