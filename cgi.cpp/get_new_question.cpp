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

#include "sqltutor.h"

void SQLtutor::get_new_question(pqxx::work& tran) 
{
  using pqxx::result;

  const std::string getnext =
    "SELECT dataset_id, problem_id, q_ord, language_id "
    "  FROM next_question(" + session_id + ", '" + hash + "')";

  result res1(tran.exec(getnext));
  result::const_iterator res = res1.begin();

  if (res[0].is_null())
    {
      dataset_id.clear();
      problem_id.clear();
      q_ord.clear();
      language_id.clear();
      throw AllQuestionsDone();
    }

  dataset_id  = res["dataset_id" ].as(std::string());
  problem_id  = res["problem_id" ].as(std::string());
  q_ord       = res["q_ord"      ].as(std::string());
  language_id = res["language_id"].as(std::string());

  const std::string insert =
    "INSERT INTO sessions_questions "
    "  (session_id, dataset_id, problem_id, q_ord, language_id, time) VALUES (" 
    + session_id + ", " + dataset_id + ", " + problem_id + ", " 
    + q_ord + ", '" + language_id + "', now() )";
  
  using namespace pqxx;
  connection c( db_connection );
  work       t(c, "get_new_question");
  set_schema(t);
  result     r(t.exec(insert));
  t.commit();

}
