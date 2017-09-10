/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008, 2017  Free Software Foundation, Inc.
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

void SQLtutor::show_sql_result()
{
  using namespace pqxx;

  connection conn( db_connection_sql ); 
  work   tran(conn, "show_sql_result");
  set_schema(tran);

  result sql_result(tran.exec(sql));
  
  const size_t columns = sql_result.columns(), total_count=sql_result.size();
  size_t       row_count = 0;

  form << "<table border='1'>";
  
  if (sql_result.empty())
    {
      form << "<tr><td><em>"  << t_empty_set << "<em/></td></tr>";
    }

  for (pqxx::result::const_iterator 
         b=sql_result.begin(), e=sql_result.end(); b!=e; b++)
    {
      if (++row_count > max_row_count && row_count != total_count) 
        {
          // IE6 doesn't honor the colspan="0", with or without a
          // colgroup defined
          // 
          // form << "<tr><td colspan='0'>"
          //      << "<i>" << remaining_rows << "</i></td></tr>";
          //
          form << "<tr><td colspan='" << columns << "'>"
               << "<i>" << remaining_rows << "</i></td></tr>";
          break;
        }
      form << "<tr>";
      for (/*size_t*/ pqxx::tuple::size_type c=0; c<columns; c++)
	if (b[c].type() == geom_oid)  // postgis geometry
	  {
	    form << "<td>" << t_geometry << "</td>";
	  }
	else
	  {
	    form << "<td>" << b[c].as(std::string()) << "</td>";
	  }
      form << "</tr>";
    }
  
  form << "</table>";
}
