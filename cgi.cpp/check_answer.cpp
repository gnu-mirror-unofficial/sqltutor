/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008, 2010, 2017  Free Software Foundation, Inc.
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
#include "permutation.h"
#include <string>
#include <sstream>
#include <vector>
#include <cctype>

namespace 
{
  std::string semicolumn(std::string sql)
  {
    if (size_t n = sql.size())
      do 
        {
          n--;
          if (sql[n] == ';') return sql.substr(0, n);
        }
      while (n > 0 && std::isspace(sql[n]));
    
    return sql;
  }

  pqxx::oid colt(pqxx::oid column_type)
  {
    // select oid, typname from pg_type;

    switch (column_type)
      {  // OID
      case   20:        // INT8       pg_type.h   
      case   21:        // INT2 
      case   23:        // INT4
      case  700:        // FLOAT4
      case  701:        // FLOAT8
      case 1700:        // NUMERIC
        return 20;

      default:
        return column_type;
      }
  }
}


void SQLtutor::check_answer(pqxx::work& tran)
{
  using namespace pqxx;
  using std::string;

  correct_answer = false; 
  if (empty(sql)) return save_answer(tran);

  { // Opening new connection for user SQLTUTOR_WWW_EXEC protects
    // against SQL injection exploits. Only dataset tables with
    // granted select are available here. Exceptions are caugth
    // outside the check_answer()
    
    connection conn( db_connection_sql ); 
    work   tran(conn, "show_sql_result");
    set_schema(tran);
    
    result sql_result(tran.exec(sql));
    sql_result_size    = sql_result.size();
    sql_result_columns = sql_result.columns();
  }

  result tmp1(tran.exec("SELECT answer"
                        "  FROM answers"
                        " WHERE dataset_id = " + dataset_id + " " 
                        "   AND problem_id = " + problem_id + " " 
                        " ORDER by priority ASC"));
  string answer = tmp1.begin()[0].as(string());

  result answer_result(tran.exec(answer));
  sql_tutor_size    = answer_result.size();
  sql_tutor_columns = answer_result.columns();

  if (sql_result_size    != sql_tutor_size ||
      sql_result_columns != sql_tutor_columns) return save_answer(tran);

  // columns of the temporary table are explicitly named c0, c1, ... cn
  std::ostringstream columns_tutor;
  for (size_t col=0; col<sql_tutor_columns; col++)
    {
      columns_tutor << "c" << col;
      if (col !=  sql_tutor_columns-1) columns_tutor << ", ";
    }

  result tmp_tutor(tran.exec("CREATE TEMPORARY TABLE tmp_tutor ( "
                             + columns_tutor.str() + " ) AS SELECT * FROM ( " 
                             + semicolumn(answer)  + " ) TMP"));
  result tmp_user (tran.exec("CREATE TEMPORARY TABLE tmp_user ( "
                             + columns_tutor.str() + " ) AS SELECT * FROM ( " 
                             + semicolumn(sql)     + " ) TMP"));
  result user_result(tran.exec("SELECT * from tmp_user"));

  std::vector<pqxx::oid> column_type_user (sql_result_columns);
  std::vector<pqxx::oid> column_type_tutor(sql_result_columns);
  for (/*size_t*/ pqxx::tuple::size_type i=0; i<sql_result_columns; i++)
    {
      column_type_user [i] = colt( user_result  .column_type(i) );
      column_type_tutor[i] = colt( answer_result.column_type(i) );
    }
 
  Permutation perm(sql_result_columns);
  first_permutation = true;
  while (!perm.empty() && !correct_answer)
    {
      bool candidate_permutation = true;
      for (size_t i=0; i<sql_result_columns; i++)
        if (column_type_user[perm[i]] != column_type_tutor[i])
          {
            candidate_permutation = false;
            break;
          }
      std::ostringstream columns_user;
      for (size_t col=0; col<sql_result_columns; col++)
        {
          columns_user << "c" << perm[col];
          if (col !=  sql_result_columns-1) columns_user << ", ";
        }


      if (candidate_permutation) 
        {
          /* split into two queries */

          string q1 = 
            "SELECT " + columns_tutor.str() + " FROM tmp_tutor "
            "EXCEPT ALL "
            "SELECT " + columns_user.str() +  " FROM tmp_user ";
          
          result tmp7(tran.exec(q1));
          if (tmp7.empty())
            {
              string q2 =
                "SELECT " + columns_user.str() +  " FROM tmp_user "
                "EXCEPT ALL "
                "SELECT " + columns_tutor.str() + " FROM tmp_tutor ";
                
              result tmp8(tran.exec(q2));
              if (tmp8.empty())
                {
                  correct_answer = true;
                  break;
                }
            }          
        }

      perm.next();
      first_permutation = false;
    }

  save_answer(tran);
}
