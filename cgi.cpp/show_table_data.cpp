/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008, 2010  Free Software Foundation, Inc.
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

using std::string;
using pqxx::result;
using pqxx::sql_error;


void SQLtutor::show_table_data(pqxx::work& tran)
try 
{
  result tables(tran.exec("SELECT ds_table, columns "
                          "  FROM questions"
                          "       NATURAL JOIN dataset_tables"
                          " WHERE dataset_id  ='" + dataset_id  + "' "
                          "   AND problem_id  ='" + problem_id  + "' "
                          "   AND q_ord       ='" + q_ord       + "' "
                          "   AND language_id ='" + language_id + "' "
                          " ORDER BY dt_ord; "));
  
  for (result::const_iterator t=tables.begin(), e=tables.end(); t!=e; t++)
    {
      const string table = t[0].as(string());

      int icols = 1;
      string columns = "<tr><th><i>";
      const string col = t[1].as(string());
      for (string::const_iterator c=col.begin(), e=col.end(); c!=e; c++)
        switch (*c)
          {
          case ',': columns += "</i></th><th><i>"; icols++; break;
          default : columns += *c;
          }
      columns += "</i></th></tr>";

      form << "<p></p><table border='1'>"
           << "<tr><th colspan='" << icols << "'>" + table + "</th></tr>";
      form << columns;

      try {
        result data(tran.exec("SELECT * FROM " + table + " ORDER BY random()"));
        size_t row_count = 0, total_count=data.size();
        size_t columns = data.columns();
        for (result::const_iterator d=data.begin(), e=data.end(); d!=e; d++)
          {
            if (++row_count > max_row_count && row_count != total_count)
              {
                form << "<tr><td colspan='" << columns << "'>"
                     << "<i>" << remaining_rows << "</i></td></tr>";
          break;
              }
            form << "<tr>";
            for (size_t i=0; i<columns; i++)
	      if (d[i].type() == geom_oid)  // postgis geometry
		{
		  form << "<td>" << t_geometry << "</td>";
		}
	      else
		{
		  form << "<td>" << d[i].as(string()) << "</td>";
		}
            form << "</tr>";
          }
      }
      catch (sql_error e)
        {
          form << e.what();
        }
      catch (std::exception& e)
        {
          form << e.what();
        }
      catch (...)
        {
          throw;
        }

      form << "</table>";
    }
}
catch (sql_error e)
{
  form << e.what();
}
catch (std::exception& e)
{
  form << e.what();
}
catch (...)
{
  throw;
}
