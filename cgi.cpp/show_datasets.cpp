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
  result res(tran.exec("SELECT DISTINCT d.dataset, t.tabscount, dt.ds_table,"
                       "                dt.columns, dt.dt_ord "
                       "  FROM datasets AS d"
                       "       JOIN "
                       "       problems AS p"
                       "       ON d.dataset_id = p.dataset_id"
                       "       JOIN"
                       "       tutorials_problems AS tp"
                       "       ON tp.problem_id = p.problem_id"
                       "          AND tp.dataset_id = d.dataset_id "
                       "          AND tp.tutorial_id = " + tutorial_id +
                       "       JOIN "
                       "       (SELECT dataset_id, count(ds_table) AS tabscount"
                       "          FROM dataset_tables "
                       "         GROUP BY dataset_id) AS t "
                       "       ON (d.dataset_id = t.dataset_id) "
                       "       JOIN "
                       "       dataset_tables AS dt"
                       "       ON dt.dataset_id = d.dataset_id "
                       " ORDER BY t.tabscount, d.dataset, dt.dt_ord; "));
  if (res.empty()) 
    {
      form << (Par() << t_no_datasets);
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
