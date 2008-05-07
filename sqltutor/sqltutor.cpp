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
 * $Id: sqltutor.cpp,v 1.1 2008/05/07 15:27:35 cepek Exp $ 
 */

#include "sqltutor.h"
#include <cctype>


SQLtutor::SQLtutor() : form(action) 
{
  CGI::map["state"]    = init_state;  // implicit initial state
  CGI::map["help"]     = "";
  
  cgi.init( title + " " + version );
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


bool SQLtutor::empty_or_reject(std::string sql)
{
  bool empty = true;
  for (std::string::const_iterator b=sql.begin(), e=sql.end(); b!=e; ++b)
    if (!std::isspace(*b))
    {
      empty = false;
      break;
    }
  if (empty) return true;


  /* rejected queries */

  if (std::string::npos != sql.find("answers"))  return true;
  if (std::string::npos != sql.find("sessions")) return true;

  return false;
}
