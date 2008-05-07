/* 
   This file is a part of SQLtutor
   Copyright (C) 2008  Ales Cepek <cepek@gnu.org>
 
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/* 
 * $Id: submit_sql.cpp,v 1.1 2008/05/07 15:27:35 cepek Exp $ 
 */

#include "sqltutor.h"

void SQLtutor::submit_sql(pqxx::work& tran)
{  
  if (empty_or_reject(sql)) return;

  check_answer(tran);

  bool error = false;
  if (sql_result_columns != sql_tutor_columns)
    {
      if (!error) form << "<b>" + t_wrong_answer + "</b><br/>";
      form << t_unmatched_cols << " " << sql_result_columns 
           << ", " << t_should_be << " " << sql_tutor_columns << "<br/>";
      error = true;
    }
  if (sql_result_size != sql_tutor_size)
    {
      if (!error) form << "<b>" + t_wrong_answer + "</b><br/>";
      form << t_unmatched_rows << " " << sql_result_size 
           << ", " << t_should_be << " " << sql_tutor_size << "<br/>";
      error = true;
    }
  
  
  if (error) return;

  if (correct_answer)
    {
      form << "<b>" + t_correct_answer + "</b><br/>";
      if (!first_permutation) form << t_permutation << "<br/>";
      sql_checked = "yes";
    }
  else
    {
      form << "<b>" + t_wrong_answer + "</b><br/>";
    }
}



