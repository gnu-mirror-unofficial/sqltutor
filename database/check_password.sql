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


CREATE OR REPLACE FUNCTION sqltutor.check_password
(
      IN  logint_      text,
      IN  password_    varchar(20),
      IN  host_        inet
) 
RETURNS integer
AS $$
DECLARE
BEGIN
   /* implicitly the function does nothing, include your own test if needed */

   IF host_ BETWEEN '147.32.142.131' AND '147.32.142.151'
   THEN
      IF password_ =  substring(host(host_-130),12,3)
      THEN
        RETURN 0;
      END IF;

      RETURN 1;
   END IF;

   RETURN 0;
END;
$$ LANGUAGE plpgsql;

