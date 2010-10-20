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
#include "cgi.h"
#include "sqltutor.h"

using std::string;


namespace
{
  string emptyrow() { return "<tr><td>&nbsp;</td></tr>";    }
  string emptycol() { return "<td>&nbsp;&nbsp;&nbsp;</td>"; }
  
  bool number(string s)
  {
    string::const_iterator b=s.begin(), e=s.end();
    while (b != e && isspace(*b)) b++;
    
    if (b == e) return true;

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

  string param(const string& ap, const string& val, 
               const string& implicit_value="NULL")
  {
    bool empty = true;
    for (string::const_iterator b=val.begin(), e=val.end(); b!=e; ++b)
      if (!std::isspace(*b))
        {
          empty = false;
          break;
        }
    if (empty) return implicit_value;

    return ap + val + ap;
  }
}


void SQLtutor::form_init()
{
  string state          = CGI::map["state"];
  const string user     = CGI::map["user"];
  const string tutorial = CGI::map["tutorial"];

  bool   error = false;
  string pmin  = CGI::map["points_min"];
  string pmax  = CGI::map["points_max"];
  string dset  = CGI::map["dataset"];

  Table perr(2);

  if (!number(pmin))
    {
      error = true;
      perr << t_bad_value_min << pmin;
    }
  if (!number(pmax))
    {
      error = true;
      perr << t_bad_value_max << pmax;
    }
  
  if (error)
    {
      CGI::map["state"] = init_state;    
    }

  if (state == init_continue && tutorial != "0")
    try 
      {
        // checked by form_main()
        if (CGI::map["help"].empty()) CGI::map["help"] = "0"; 

        const string ihelp = (CGI::map["help"] == "true") ? "1" : "0";
        const string open = 
          "SELECT session_id_, hash_ FROM open_session (" +
          param(" ", tutorial                    ) + ", " +
          param("'", CGI::map["user"]            ) + ", " +
          param("'", CGI::map["password"]        ) + ", " +
          param(" ", CGI::map["points_min"], "0" ) + ", " +
          param(" ", CGI::map["points_max"], "0" ) + ", " +
          param("'", CGI::map["dataset"]         ) + ", " +
          param(" ", ihelp,                  "0" ) + ", " +
          param("'", CGI::getenv("REMOTE_ADDR")  ) + ");";

        using namespace pqxx;
        connection  conn( db_connection );
        work   tran(conn, "form_init");
        set_schema(tran);
        result res1(tran.exec(open));
        result::const_iterator q = res1.begin();
        if (q == res1.end())
	  {
	    error = true;
	    perr << "Login failed for user ";
	    if (user.empty()) 
	      perr << "...";
	    else
	      perr << user;
	  }
	else
	  {
	    string session_id  = q[0].as(string());
	    string hash        = q[1].as(string());
	    tran.commit();
	    
	    CGI::map.clear();
	    CGI::map["session_id"] = session_id;
	    CGI::map["state"]      = main_next;
	    CGI::map["hash"]       = hash;
	    
	    return form_main();
	  }
      }
    catch (const std::exception& s) 
      {
        form << s.what() << "<br/><br/>";
        form_stop();
        return;
      }

  Strong welcome;
  welcome << t_welcome;
  form    << (Par() << welcome);

  if (error)
    {
      form << perr << "<br/>";
    }
  
  form << "<table>";
  form << "<tr>" 
       << "<td>" + t_tutorial + "</td>"
       << "<td>"
       << tutorial_selection()
       << "</td>"
       << "</tr>";
  form << emptyrow();
  form << "<tr>"
       << "<td>" + t_user + "</td>"
       << "<td>" 
       << InputText("user").value("")
       << "</td>"
       << emptycol()
       << "<td>" + t_password + "</td>"
       << "<td>"
       << InputPassword("password").value("")
       << "</td>"
       << "</tr>";
  form << emptyrow();
  form << "<tr>"
       << "<td>" + t_points_min + "</td>"
       << "<td>"
       << InputText("points_min").value(pmin)
       << "</td>"
       << emptycol()
       << "<td>" + t_points_max + "</td>"
       << "<td>"
       << InputText("points_max").value(pmax)
       << "</td>"
       << "</tr>";
  form << "<tr>"
       << "<td>" + t_dataset + "</td>"
       << "<td>"
       << InputText("dataset").value(dset) 
       << "</td>" 
       << emptycol()
       << "<td>" + t_help + "</td>"
       << "<td>";

  form << InputCheckbox("help").value("true").checked(!CGI::map["help"].empty());

  form << "</td>"
       << "</tr>";
  form << emptyrow();
  form << "</table>";

  form << "<p>";
  form << InputSubmit("state").value(init_continue)
       << button_sep()
       << InputSubmit("state").value(init_datasets)
       << button_sep()
       << InputSubmit("state").value(init_manual);
  form << "</p>";

  const string prev_state = CGI::map["prev_state"];

  if (prev_state != init_datasets && state == init_datasets && tutorial != "0")
    {
      form << InputHidden("prev_state").value(init_datasets);
      show_datasets();
    }

  if (prev_state != init_manual && state == init_manual)
    {
      form << InputHidden("prev_state").value(init_manual);
      getting_started();
    }

  if (tutorial == "0" && (state == init_datasets || state == init_continue))
    {
      form << "<p>"
           << t_select_tutorial
           << "</p>";
    }
}
