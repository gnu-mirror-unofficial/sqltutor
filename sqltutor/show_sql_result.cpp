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
 * $Id: show_sql_result.cpp,v 1.1 2008/05/07 15:27:35 cepek Exp $ 
 */

#include "sqltutor.h"

void SQLtutor::show_sql_result(pqxx::work& tran)
{
  using namespace pqxx;

  std::string::size_type fake = sql.find("answers");
  if (fake != std::string::npos)
    {
      return; 
    }

  result sql_result(tran.exec(sql));
  
  const size_t columns = sql_result.columns(), total_count=sql_result.size();
  size_t       max_count=50, row_count = 0;

  form << "<table border='1'>";
  
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
