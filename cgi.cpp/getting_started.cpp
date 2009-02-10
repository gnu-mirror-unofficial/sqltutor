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
 * $Id: getting_started.cpp,v 1.1 2009/02/10 18:19:09 cepek Exp $ 
 */

#include <pqxx/pqxx>
#include "sqltutor.h"

using std::string;
using pqxx::result;
using pqxx::sql_error;


void SQLtutor::getting_started()
{
  Par title;
  title << "<strong> Getting Started with GNU Sqltutor</strong>";
  form << title;

  Par p1;
  p1 << 
    "GNU Sqltutor is a web based interactive tutorial of "
     << "Structured Query Language (SQL).";
  form << p1;

  Par p2;
  p2 << 
    "First, a <em>tutorial</em> "
    "must be selected from the opening page (drop down menu) and started. "
    "A series of tutorial questions follows in a simple dialog. When "
    "finished SQLtutor displays final evaluation with the review of all "
    "questions asked during the session together with user's SQL queries "
    "and correct answers for wrong solutions. ";
  form << p2;

  Par p3;
  p3 << "Sqltutor manual online is available from "
     << "<a href='http://www.gnu.org/software/sqltutor/manual/'"
     << ">http://www.gnu.org/software/sqltutor</a>.";  
  form << p3;
}
