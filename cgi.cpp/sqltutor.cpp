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
 * $Id: sqltutor.cpp,v 1.1 2008/12/26 17:23:07 cepek Exp $ 
 */

#include "sqltutor.h"
#include <cctype>


SQLtutor::SQLtutor() : cgi(*CGI::instance()), form(action) 
{
  cgi.set_title(title + " " + version );
}


SQLtutor::~SQLtutor()
{
}


void SQLtutor::run()
{
  std::string state = CGI::map["state"];

  if      (state == main_sql      ||
           state == main_next     ||
           state == main_data     ||
           state == main_help     ||
           state == main_state    ||
           state == main_stop)        form_main();
  else if (state == init_state    || 
           state == init_continue || 
           state == init_datasets)    form_init();
  else
    {
      form << title + " : " + t_unknown_state + " " << state;
    }
  
  cgi << form;
  cgi.run();
}


bool SQLtutor::empty(std::string sql)
{
  bool empty = true;
  for (std::string::const_iterator b=sql.begin(), e=sql.end(); b!=e; ++b)
    if (!std::isspace(*b))
    {
      empty = false;
      break;
    }

  return empty;
}


std::string SQLtutor::tutorial_selection()
{
  try
    {
      using namespace pqxx;        
      connection  conn( db_connection );
      work   tran(conn, "tutorial_selection");
      set_schema (tran);
      result res1(tran.exec("SELECT tutorial_id, language, tutorial, label"
                            "  FROM tutorials"
                            " ORDER BY ord ASC, language ASC, label ASC;"));

      std::string s, language, last, tutorial = CGI::map["tutorial"];
      if (tutorial.empty()) tutorial = "0";
      
      std::string description = "None";
      result res2(tran.exec("SELECT tutorial"
                            "  FROM tutorials"
                            " WHERE tutorial_id=" + tutorial));
      if (!res2.empty()) description = res2.begin()[0].as(std::string());
      
      s += "<select name='tutorial'>";
      s += "<option selected value='" + tutorial + "'>" + description + "</option>";
      for (result::const_iterator t=res1.begin(); t!=res1.end(); ++t)
        {
          tutorial    = t[0].as(std::string());
          language    = t[1].as(std::string());
          description = t[2].as(std::string());

          if (language != last)
            {
              if (!last.empty()) s += "</optgroup>";
              s += "<optgroup label='" + language + "'>";
            }
          s += "<option value='" + tutorial + "'>" + description + "</option>";

          last = language;
        }
      s += "</optgroup>";
      s += "</select>";

      return s;
    }
  catch (const std::exception& e)
    {
      return e.what();
    }
  catch (...)
    {
      return "None available!";
    }
}
