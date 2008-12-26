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
 * $Id: form_stop.cpp,v 1.1 2008/12/26 17:23:06 cepek Exp $ 
 */

#include <pqxx/pqxx>
#include "cgi.h"
#include "sqltutor.h"
#include "display_answers.h"


void SQLtutor::form_stop()
{
  using namespace pqxx;
  using std::string;

  form << "<p>" << test_finished << "&nbsp;&nbsp; ";
  if (question_id.empty()) form << t_stopped_done << "&nbsp;&nbsp; ";

  try
    {
      connection conn( db_connection );
      work   tran(conn, "form_stop");
      set_schema(tran);

      {
        string time =
          "SELECT cast( ("
          "   (SELECT max(time) FROM sessions_answers "
          "                          WHERE session_id=" + session_id + ") - "
          "   (SELECT time      FROM sessions "
          "                          WHERE session_id=" + session_id +") )"
          " AS interval(0) ) ";
        result res(tran.exec(time));

        form << res.begin()[0].as(string()) 
             << "&nbsp;&nbsp; (" << t_session << session_id << ")"
             << "</p>";
      }

      string query    = "select ";

      query += 
        "(SELECT count(id) "
        "  FROM questions "
        " WHERE tutorial_id = '" + tutorial_id + "'"
        "   AND id IN (SELECT question_id "
        "                FROM sessions_answers "
        "               WHERE session_id = " + session_id + ")), ";
      
      query += 
        "(SELECT count(id) "
        "  FROM questions "
        " WHERE tutorial_id = '" + tutorial_id + "'"
        "   AND id IN (SELECT question_id "
        "                FROM sessions_answers "
        "               WHERE session_id = " + session_id + " "
        "                     AND correct)), ";
 
      query +=   
        "(SELECT coalesce(sum(points), '0') "
        "  FROM questions "
        " WHERE tutorial_id = '" + tutorial_id + "'"
        "   AND id IN (SELECT question_id "
        "                FROM sessions_answers "
        "               WHERE session_id = " + session_id + " "
        "                     AND correct)), ";
 
      query +=
        " points_min, points_max, dataset, help "
        " FROM sessions "
        "WHERE session_id=" + session_id + " ";

      result res(tran.exec( query ));
      result::const_iterator r=res.begin(), e=res.end();
      if (r != e)
        {
          int total         = r[0].as(int());
          int correct       = r[1].as(int());
          int points        = r[2].as(int());
          string points_min = r[3].as(string());
          string points_max = r[4].as(string());
          string dataset    = r[5].as(string());
          bool help         = r[6].as(bool());

          bool pars = !points_min.empty() ||
                      !points_max.empty() || 
                      !dataset.empty();  

          string style = "";
          if ( help || pars)
            { 
              style = "style='color:red'";
            }

          form << "<table border='0' " + style + ">"
               << "<tr>"
               << "<td>" + t_nmbr_questions + "</td>"
               << "<td>:&nbsp;</td><td align='right'>" << total << "</td>"
               << "</tr>"
               << "<tr>"
               << "<td>" + t_nmbr_cor_answs + "</td>"
               << "<td>:&nbsp;</td><td align='right'>" << correct << "</td>"
               << "</tr>"
               << "<tr>"
               << "<td>" + t_total_points + "</td>"
               << "<td>:&nbsp;</td><td align='right'>" << points << "</td>"
               << "</tr>"
               << "<tr>"
               << "<td>" + t_evaluation + "</td>"
               << "<td>:&nbsp;</td><td align='right'>" 
               << int( double(points*correct)/double(std::max(1, total)) ) 
               << "</td>"
               << "</tr>";

          if (pars)
            {
              form << "<tr><td></td><td></td><td></td><td>"
                   << "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                   << "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                   << "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                   << "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                   << "</td></tr>"
                   << "<tr>"
                   << "<td>" + t_points_min + "</td>"
                   << "<td>:&nbsp;</td><td align='right'>" << points_min << "</td>"
                   << "</tr>"
                   << "<tr>"
                   << "<td>" + t_points_max + "</td>"
                   << "<td>:&nbsp;</td><td align='right'>" << points_max << "</td>"
                   << "</tr>"
                   << "<tr>"
                   << "<td>" + t_dataset + "</td>"
                   << "<td>:&nbsp;</td><td align='left' colspan=2>" << dataset << "</td>"
                   << "</tr>";
            }

          form << "</table>";
        }

      form  << "<br/>" 
            << Input().type("submit").value( new_test );
      form << "<br/>";

      display_answers(form, tran, session_id);
  
      {
        string close = 
          "UPDATE sessions SET status='closed' "
          " WHERE session_id = " + session_id +
          "   AND '" +  CGI::map["hash"] + "' = md5(time);";
      
      result res(tran.exec(close));
      tran.commit();
      }

      CGI::map.clear();
      CGI::map["state"] = init_state;
    }
  catch (sql_error s)
    {
      s.what();
    }
  catch (...)
    {
      throw;
    }
}


