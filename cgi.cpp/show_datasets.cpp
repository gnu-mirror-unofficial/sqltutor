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
 * $Id: show_datasets.cpp,v 1.3 2009/04/01 18:12:38 cepek Exp $ 
 */

#include <pqxx/pqxx>
#include "sqltutor.h"

using std::string;
using pqxx::result;
using pqxx::sql_error;


void SQLtutor::show_datasets()
{
  const string tutorial_id = CGI::map["tutorial"];

  using namespace pqxx;
  connection  conn( db_connection );
  work   tran(conn, "show_datasets");
  set_schema(tran);
  result res(tran.exec(
                       "SELECT t.dataset, t.tabscount, d.ds_table, d.columns "
                       "  FROM datasets AS d"
                       "       JOIN "
                       "       (SELECT dataset, count(ds_table) as tabscount "
                       "          FROM datasets "
                       "         GROUP BY dataset) AS t "
                       "       ON (d.dataset = t.dataset) "
                       "       JOIN "
                       "       (SELECT DISTINCT dataset "
                       "          FROM questions "
                       "         WHERE tutorial_id=" + tutorial_id + ") AS q "
                       "       ON (d.dataset = q.dataset) "
                       " ORDER BY t.tabscount, t.dataset, d.ord; "
                       ));

  if (res.empty()) 
    {
      form << "<p>" << t_no_datasets << "</p>";
      return;
    }

  form << "<table border='1' >"
       << "<tr><th> dataset</th><th>table</th><th>columns</th></tr>";

  int tabs = 0;
  for (result::const_iterator b=res.begin(), e=res.end(); b!=e; b++)
    {
      form << "<tr>";
      if (tabs == 0)
        {
          tabs = b[1].as(int());
          form << "<td  valign='top' rowspan='" + b[1].as(string()) + "'> "
               << b[0].as(string())
               << " </td>";
        }
      tabs--;
      form << "<td> " + b[2].as(string()) + " </td>"
           << "<td> " + b[3].as(string()) + " </td>"
           << "</tr>";
    }
  form << "</table>";
}
