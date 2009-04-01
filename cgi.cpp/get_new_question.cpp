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

/* 
 * $Id: get_new_question.cpp,v 1.3 2009/04/01 18:12:37 cepek Exp $ 
 */

#include "sqltutor.h"

void SQLtutor::get_new_question(pqxx::work& tran) 
{
  using pqxx::result;

  result res1(tran.exec("SELECT next_tutorial_id, next_question_id"
                        "  FROM next_question(" 
                        + session_id + ", '" + hash + "')" ));
  if (res1.begin()[0].is_null() || res1.begin()[1].is_null())
    {
      question_id.clear();
      throw AllQuestionsDone();
    }

  tutorial_id = res1.begin()[0].as(std::string());
  question_id = res1.begin()[1].as(std::string());

  const std::string insert =
    "INSERT INTO sessions_answers "
    "   (session_id, tutorial_id, question_id, time) VALUES (" 
    + session_id + ", " + tutorial_id + ", " + question_id + ", now() )";

  using namespace pqxx;
  connection c( db_connection );
  work       t(c, "get_new_question");
  set_schema(t);
  result     r(t.exec(insert));
  t.commit();
}
