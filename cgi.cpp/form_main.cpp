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
 * $Id: form_main.cpp,v 1.2 2008/12/28 14:17:26 cepek Exp $ 
 */

#include <pqxx/pqxx>
#include "cgi.h"
#include "sqltutor.h"


void SQLtutor::form_main()
{
  using namespace pqxx;
  using std::string;

  const string state = CGI::map["state"];
  session_id  = CGI::map["session_id"];
  sql_checked = CGI::map["sql_checked"];
  question_id = CGI::map["question_id"];
  hash        = CGI::map["hash"];
  bool help = false;

  try    
    {
      connection  conn( db_connection );
      work   tran(conn, "form_main3");
      set_schema(tran);
  
      result session(tran.exec("SELECT help, tutorial_id FROM sessions"
                               " WHERE session_id = " + session_id + ""));
      
      help        = session.begin()[0].as(bool());
      tutorial_id = session.begin()[1].as(string());
  

      if (state == main_stop) 
        {
          sql = CGI::map["sql_query"];
          if (sql_checked != "yes" && !empty(sql))
            try
              {
                connection   conn( db_connection );
                work   tran (conn, "form_main1");
                set_schema(tran);
                check_answer(tran);
              }
            catch (sql_error err)
              {
                // we need to catch syntax errors and save wrong answers 
                connection   conn( db_connection );
                work   tran (conn, "form_main2");
                set_schema(tran);
                sql = std::string(err.what()) + "\n" + sql;
                save_answer(tran);
              }
            catch (...)
              {
                throw;
              }
          
          return form_stop();
        }


      if (state == main_next)
        {
          sql = CGI::map["sql_query"];
          if (sql_checked != "yes" && !empty(sql))
            try {
              connection   conn( db_connection );
              work   tran (conn, "form_main4");
              set_schema(tran);
              check_answer(tran);
            }
            catch (sql_error err)
              {
                // we need to catch syntax errors and save wrong answers 
                sql = std::string(err.what()) + "\n" + sql;
                save_answer(tran);
              }
            catch (...)
              {
                throw;
              }
          
          CGI::map["sql_query"] = "";
          sql_checked = "no";
          get_new_question(tran);
        }

      form << InputHidden("sql_checked").value( sql_checked );
      form << InputHidden("session_id" ).value( session_id  );
      form << InputHidden("hash"       ).value( hash        );
      form << InputHidden("tutorial_id").value( tutorial_id );
      form << InputHidden("question_id").value( question_id );

      form << "<p style='text-align:right'>";
      form << InputSubmit("state").value(main_stop);
      form << "</p>";

      display_question(form, tran, tutorial_id, question_id);
      form << InputSubmit("state"      ).value( main_next   );
      
      sql = CGI::map["sql_query"];

      form << "<br/><br/><textarea name='sql_query' rows='15' cols='80'>";
      form << sql;
      form << "</textarea><br/>";
      form << InputSubmit("state").value(main_sql);
      form << button_sep();
      form << InputSubmit("state").value(main_data);
      if (help)
        {
          form << button_sep();
          form << InputSubmit("state").value(main_help);
        }
      form << "<br/><br/>";


      if (state == main_data)
        {
          show_table_data(tran);
        }
      if (state == main_help)
        {
          result tmp(tran.exec("SELECT answer FROM answers"
                               " WHERE tutorial_id = '" + tutorial_id + "'"
                               "   AND question_id = '" + question_id + "'"));
          
          for (result::const_iterator a=tmp.begin(), e=tmp.end(); a!=e; a++)
            {
              form << "<PRE>";
              form << a[0].as(string()) << "\n";
              form << "</PRE>";
            }
        }

      if (!empty(sql))
        try 
          {
            submit_sql(tran);
            show_sql_result();
          }
        catch (sql_error s)
          {
            form << s.what();
          }
        catch (...)
          {
            form << t_sql_error;
          }
      
      form << InputHidden("sql_checked").value( sql_checked );
    }
  catch (sql_error s)
    {
      form << s.what();
      form_stop();
      return;
    }
  catch (AllQuestionsDone)
    {
      form_stop();
      return;
    }
  catch (...)
    {
      form << t_stopped_failed;
      form_stop();
      return;
    }
}


