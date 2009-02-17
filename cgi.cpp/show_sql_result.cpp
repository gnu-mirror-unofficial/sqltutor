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

/* 
 * $Id: show_sql_result.cpp,v 1.2 2009/02/17 15:20:34 cepek Exp $ 
 */

#include "sqltutor.h"

void SQLtutor::show_sql_result()
{
  using namespace pqxx;

  connection conn( db_connection_sql ); 
  work   tran(conn, "show_sql_result");
  set_schema(tran);

  result sql_result(tran.exec(sql));
  
  const size_t columns = sql_result.columns(), total_count=sql_result.size();
  size_t       max_count=50, row_count = 0;

  form << "<table border='1'>";
  
  if (sql_result.empty())
    {
      form << "<tr><td><em>&nbsp;"  << t_empty_set << "&nbsp;<em/></td></tr>";
    }

  for (pqxx::result::const_iterator 
         b=sql_result.begin(), e=sql_result.end(); b!=e; b++)
    {
      if (++row_count > max_count && row_count != total_count) 
        {
          form << "<tr><td colspan='0'>"
               << "<i>" << remaining_rows << "</i></td></tr>";
          break;
        }
      form << "<tr>";
      for (size_t c=0; c<columns; c++)
        {
          form << "<td> &nbsp; " << b[c].as(std::string()) << " &nbsp; </td>";
        }
      form << "</tr>";
    }
  
  form << "</table>";
}
