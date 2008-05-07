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
 * $Id: show_table_data.cpp,v 1.1 2008/05/07 15:27:35 cepek Exp $ 
 */

#include "sqltutor.h"

using std::string;
using pqxx::result;
using pqxx::sql_error;


void SQLtutor::show_table_data(pqxx::work& tran)
try 
{
  result tables(tran.exec("SELECT ds_table, columns "
                          "  FROM questions Q "
                          "       JOIN "
                          "       datasets  D "
                          "       ON Q.dataset = D.dataset "
                          "          AND id='" + question_id + "' "
                          " ORDER BY ord; "));
  
  for (result::const_iterator t=tables.begin(), e=tables.end(); t!=e; t++)
    {
      const string table = t[0].as(string());

      form << "<table border='1'>"
           << "<tr><th colspan='0'>" + table + "</th></tr>";

      string columns = "<tr><th><i>";
      const string col = t[1].as(string());
      for (string::const_iterator c=col.begin(), e=col.end(); c!=e; c++)
        switch (*c)
          {
          case ',': columns += "</i></th><th><i>"; break;
          default : columns += *c;
          }
      columns += "</i></th></tr>";
      form << columns;

      {
        result data(tran.exec("SELECT * FROM " + table));
        size_t columns = data.columns();
        for (result::const_iterator d=data.begin(), e=data.end(); d!=e; d++)
          {
            form << "<tr>";
            for (size_t i=0; i<columns; i++)
              {
                form << "<td>" << d[i].as(string()) << "</td>";
              }
            form << "</tr>";
          }
      }

      form << "</table>"
           << "<br/>";
    }
}
catch (sql_error)
{
}
catch (...)
{
  throw;
}
