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
 * $Id: form_init.cpp,v 1.8 2008/12/25 15:29:18 cepek Exp $ 
 */

#include <pqxx/pqxx>
#include "cgi.h"
#include "sqltutor.h"

using std::string;


namespace
{
  string emptyrow() { return "<tr><td>&nbsp;</td></tr>";     }
  string emptycol() { return "<td>&nbsp;&nbsp;&nbsp;</td>"; }
  
  bool number(string s)
  {
    if (s.empty()) return true;
    
    string::const_iterator b=s.begin(), e=s.end();
    while (b != e && isspace(*b)) b++;
    
    int count = 0;
    while (b != e)
      {
        if (!isdigit(*b)) return false;
        count++;
        b++;
      }
    if (count == 0 || count > 5) return false;  // number too big
    
    while (b != e)
      {
        if (!isspace(*b)) return false;
        b++;
      }
    
    return true;
  }

  string param(const string& ap, const string& val)
  {
    bool empty = true;
    for (string::const_iterator b=val.begin(), e=val.end(); b!=e; ++b)
      if (!std::isspace(*b))
        {
          empty = false;
          break;
        }
    if (empty) return "NULL";

    return ap + val + ap;
  }
}


void SQLtutor::form_init()
{
  const string state    = CGI::map["state"];
  const string user     = CGI::map["user"];
  const string tutorial = CGI::map["tutorial"];

  bool   error = false;
  string pmin  = CGI::map["points_min"];
  string pmax  = CGI::map["points_max"];
  string dset  = CGI::map["dataset"];

  if (!number(pmin))
    {
      error = true;
      form << t_bad_value_min << ": " << pmin << " <br/>";
    }
  if (!number(pmax))
    {
      error = true;
      form << t_bad_value_max << ": " << pmax << " <br/>";
    }
  
  if (error)
    {
      CGI::map["state"] =  init_state;
      CGI::map["user"]  = "";
      
      form << "<br/>";
      form_init();
      return;
    }
  
  if (state == init_continue && tutorial != "0")
    try 
      {
        string help; 
        if (!CGI::map["help"].empty())
          help = "true";
        else
          help = "false";

        const string open = 
          "SELECT session_id_, hash_ FROM open_session (" +
          param(" ", tutorial                  ) + ", " +   
          param("'", CGI::map["user"]          ) + ", " +   
          param("'", CGI::map["password"]      ) + ", " +  
          param(" ", CGI::map["points_min"]    ) + ", " +  
          param(" ", CGI::map["points_max"]    ) + ", " +  
          param("'", CGI::map["dataset"]       ) + ", " +  
          param(" ", help                      ) + ", " +  
          param("'", CGI::getenv("REMOTE_ADDR")) + ");";

        using namespace pqxx;
        connection  conn( db_connection );
        work   tran(conn, "form_init");
        set_schema(tran);
        result res1(tran.exec(open));
        result::const_iterator q = res1.begin();
        if (q == res1.end()) throw "...";
        string session_id  = q[0].as(string());
        string hash        = q[1].as(string());
        tran.commit();
        
        CGI::map.clear();
        CGI::map["session_id"] = session_id;
        CGI::map["state"]      = main_next;
        CGI::map["hash"]       = hash;
        CGI::map["help"]       = help;            // checked by form_main() 

        return form_main();
      }
    catch (const std::exception& s) 
      {
        form << s.what() << "<br/><br/>";
        form_stop();
        return;
      }
  
  form << "<table>";
  form << "<tr>" 
       << "<td>" + t_tutorial + "&nbsp;</td>"
       << "<td>"
       << tutorial_selection()
       << "</td>"
       << "</tr>";
  form << emptyrow();
  form << "<tr>"
       << "<td>" + t_user + "&nbsp;</td>" 
       << "<td>" 
       << Input().type("text").name("user").value("guest").disabled()
       << "</td>"
       << emptycol()
       << "<td>" + t_password + "&nbsp;</td>"
       << "<td>"
       << Input().type("password").name("password").value("").disabled()
       << "</td>"
       << "</tr>";
  form << emptyrow();
  form << "<tr>"
       << "<td>" + t_points_min + "&nbsp;</td>"
       << "<td>"
       << Input().type("text").name("points_min").value(pmin)
       << "</td>"
       << emptycol()
       << "<td>" + t_points_max + "&nbsp;</td>" 
       << "<td>"
       << Input().type("text").name("points_max").value(pmax)
       << "</td>"
       << "</tr>";
  form << "<tr>"
       << "<td>" + t_dataset + "&nbsp;</td>"
       << "<td>"
       << Input().type("text").name("dataset").value(dset) 
       << "</td>" 
       << emptycol()
       << "<td>" + t_help + "&nbsp;</td>"
       << "<td>";

  form << Input().type("checkbox").name("help").value("true").checked(!CGI::map["help"].empty());
  CGI::map["help"].erase();

  form << "</td>"
       << "</tr>";
  form << emptyrow();
  form << "</table>";

  form << "<p>";
  form << Input().type("submit").name("state").value(init_continue)
       << button_sep()
       << Input().type("submit").name("state").value(init_datasets);

  if (state == init_datasets && tutorial != "0")
    {
      show_datasets();
    }

  form << "</p>";

  if (tutorial == "0" && (state == init_datasets || state == init_continue))
    {
      form << "<p>"
           << t_select_tutorial
           << "</p>";
    }
}
