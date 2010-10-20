/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008, 2010  Free Software Foundation, Inc.
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


void SQLtutor::form_main()
{
  using namespace pqxx;
  using std::string;

  const string state = CGI::map["state"];
  session_id  = CGI::map["session_id" ];
  sql_checked = CGI::map["sql_checked"];
  dataset_id  = CGI::map["dataset_id" ];
  problem_id  = CGI::map["problem_id" ];
  q_ord       = CGI::map["q_ord"      ];
  language_id = CGI::map["language_id"];
  hash        = CGI::map["hash"       ];
  all_qasked  = CGI::map["all_qasked" ];
  int help = (sql_checked == "yes") ? 1 : 0;

  try    
    {
      connection  conn( db_connection );
      work   tran(conn, "form_main3");
      set_schema(tran);
  
      result session(tran.exec("SELECT help, tutorial_id FROM sessions"
                               " WHERE session_id = " + session_id + ""));
      
      help        = session.begin()[0].as(int());
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
      form << InputHidden("dataset_id" ).value( dataset_id  );
      form << InputHidden("problem_id" ).value( problem_id  );
      form << InputHidden("q_ord"      ).value( q_ord       );
      form << InputHidden("language_id").value( language_id );

      form << "<p style='text-align:right'>";
      form << InputSubmit("state").value(main_stop);
      form << "</p>";

      display_question(form, tran, dataset_id, problem_id, q_ord, language_id);
      form << InputSubmit("state"      ).value( main_next   );
      
      sql = CGI::map["sql_query"];

      form << "<p><textarea name='sql_query' rows='15' cols='80'>";
      form << sql;
      form << "</textarea><p/><p>";
      form << InputSubmit("state").value(main_sql);
      form << button_sep();
      form << InputSubmit("state").value(main_data);
      if (help)
        {
          form << button_sep();
          form << InputSubmit("state").value(main_help);
        }
      form << "<p/>";

      const string prev_state = CGI::map["prev_state"];

      if (prev_state != main_data && state == main_data)
        {
          form << InputHidden("prev_state").value(main_data);
          show_table_data(tran);
        }

      if (prev_state != main_help && state == main_help)
        {
          form << InputHidden("prev_state").value(main_help);

          result tmp(tran.exec("SELECT answer "
                               "  FROM answers "
                               " WHERE dataset_id = " + dataset_id + " "
                               "   AND problem_id = " + problem_id + " "
                               " ORDER BY priority ASC"));
          
          for (result::const_iterator a=tmp.begin(), e=tmp.end(); a!=e; a++)
            {
              form << (Pre() << a[0].as(string()));
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
      all_qasked = t_stopped_done;
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


