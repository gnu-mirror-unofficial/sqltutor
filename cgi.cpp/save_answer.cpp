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

namespace 
{
  std::string apostrophes(const std::string& sql)
  {
    std::string tmp;
    for (std::string::const_iterator b=sql.begin(), e=sql.end(); b!=e; ++b)
      switch (*b)
        {
        case '\'': tmp += '\'';
        default  : tmp += *b;
        }
    return tmp;
  }
}

void SQLtutor::save_answer(pqxx::work& transaction)
{
  const std::string correct = correct_answer ? "1" : "0";
  if (correct_answer) sql_checked = "yes";

  std::string tmp = "'" + apostrophes(sql) + "'"; 
  if (empty(sql)) tmp = "NULL";

  using namespace pqxx;
  connection  conn( db_connection );
  work   tran(conn, "save_answer");
  set_schema(tran);

  result res2(tran.exec("SELECT is_open "
                        "  FROM sessions "
                        " WHERE session_id = " + session_id + " "
                        "   AND '" +  CGI::map["hash"] + "' = md5(cast(start as TEXT));"
                        ));

  if (res2.empty()) 
    {
      form << t_session_unknown;
      return;
    }

  result::const_iterator r=res2.begin();
  if (r[0].as(int()) == 0) 
    {
      form << t_session_closed;
      return;
    }

  result res1(tran.exec("UPDATE sessions_questions "
                        "   SET correct = " + correct + ", "
                        "       answer = " + tmp + ", "
                        "       time = now() "
                        " WHERE session_id  = " + session_id  + " "
                        "   AND dataset_id  = " + dataset_id  + " "
                        "   AND problem_id  = " + problem_id  + " "
                        "   AND q_ord       = " + q_ord       + " "
                        "   AND language_id ='" + language_id + "'"
                        ));
  tran.commit();
}
