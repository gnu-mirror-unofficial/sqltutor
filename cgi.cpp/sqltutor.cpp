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

#include "sqltutor.h"
#include <cctype>


SQLtutor::SQLtutor() : form(action) 
{
  std::string datasets;
  pqxx::connection  conn( db_connection );
  {
    pqxx::work tran(conn, "datasets_version");
    pqxx::result version(tran.exec("SELECT sqltutor.datasets_version()"));
    if (!version.empty())
      {
        datasets = " / datasets " + version.begin()[0].as(std::string());
      }
  }

  cgi.set_title(title + " " + version + datasets);

  cgi.set_style("body { "
		"margin: 1em 1em 1em 1em; background-color: #f4f4f4; "
		"} "
		"input, select, optgroup { color: #000050; } " // #527bbd
                "table { "
                "border-collapse: collapse; border-color: #000050; "
		"} "
		"td, th { padding-left : 0.5em; padding-right: 0.5em } "
		"textarea { font-family: monospace; } "
		);

  std::string state = CGI::map["state"];
  if (state == reload_page)
    {
      CGI::map["state"] = state = main_stop;
    }

  // postgis geometry type

  using namespace pqxx;        
  work         tran(conn, "geometry_type");
  pqxx::result has_geom(tran.exec("SELECT oid FROM pg_type"
                                  " WHERE typname = 'geometry';"));
  if (!has_geom.empty())                                                        
    geom_oid = has_geom.begin()[0].as(int());                                   
  else                                                                          
    geom_oid = -1; 

  /*
  Table debug(2, "style='color:blue'");
  for(CGI::Map::const_iterator m=CGI::map.begin(), e=CGI::map.end(); m!=e; ++m)
    {
      debug << m->first << m->second;
    }
  cgi << debug;
  */
}


SQLtutor::~SQLtutor()
{
}


void SQLtutor::run()
{
  try
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
               state == init_manual   || 
               state == init_datasets)    form_init();
      else
        {
          form << title + " : " + t_unknown_state + " " << state;
        }  
    }
    catch (const std::exception& e)
    {
      cgi << e.what();
    }
  catch (...)
    {
      cgi << "Unknown exception!";
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


Select SQLtutor::tutorial_selection()
{
  try
    {
      using namespace pqxx;        
      connection  conn( db_connection );
      work   tran(conn, "tutorial_selection");
      set_schema (tran);
      result res1(tran.exec("SELECT tutorial_id, language, tutorial"
                            "  FROM tutorials"
                            "       NATURAL JOIN"
                            "       languages"
                            " ORDER BY t_ord ASC, language ASC;"));

      std::string s, tutorial_id = CGI::map["tutorial"];
      if (tutorial_id.empty()) tutorial_id = "0";
      
      std::string description = "None";
      result res2(tran.exec("SELECT tutorial"
                            "  FROM tutorials"
                            " WHERE tutorial_id=" + tutorial_id));
      if (!res2.empty()) description = res2.begin()[0].as(std::string());

      std::string language, previous;
      Select select("tutorial");
      select << Option(tutorial_id, description);
      Optgroup optgroup("");
      for (result::const_iterator t=res1.begin(); t!=res1.end(); ++t)
        {
          tutorial_id = t[0].as(std::string());
          language    = t[1].as(std::string());
          description = t[2].as(std::string());

          if (language != previous)
            {
              if (!previous.empty()) select << optgroup;
              optgroup = Optgroup(language);
            }
          previous = language;

          optgroup << Option(tutorial_id, description); 
        }
      select << optgroup;         

      return select;
    }
  catch (const std::exception& e)
    {
      //return e.what();
    }
  catch (...)
    {
      //return "None available!";
    }
}


void SQLtutor::display_answers(Form& form, 
                               pqxx::work& tran, std::string session_id)
{
  using namespace pqxx;
  using std::string;

  form << Par();

  string query1 =
    "SELECT P.dataset_id, P.problem_id, points, correct, "
    "       answer AS user_answer, help, SQ.q_ord, SQ.language_id, "
    "       D.dataset "
    "  FROM sessions AS S "
    "       JOIN sessions_questions AS SQ "
    "            ON S.session_id=SQ.session_id "
    "       JOIN problems AS P "
    "            ON SQ.dataset_id=P.dataset_id "
    "               AND SQ.problem_id=P.problem_id "
    "       JOIN datasets AS D"
    "            ON P.dataset_id=D.dataset_id "
    " WHERE S.session_id=" + session_id + " "
    " ORDER BY time ASC ";

  form << "<dl>";
  bool first = true;

  result res1(tran.exec(query1));

  for (result::const_iterator r=res1.begin(), e=res1.end(); r!=e; ++r)
    {
      string  dataset_id = r[0].as(string());
      string  problem_id = r[1].as(string());
      int         points = r[2].as(int());
      int        correct = r[3].as(int());
      string user_answer = r[4].as(string());
      int           help = r[5].as(int());
      string       q_ord = r[6].as(string());
      string language_id = r[7].as(string());
      string     dataset = r[8].as(string());

      if (first && help)
        form << "<p><strong style='color:red'>" + t_help_on + "</strong></p>";
      first = false;

      form << "<dt style='color:"
           << (correct ? "green" : "red'")
           << "';><strong>" << dataset << " " << problem_id 
           << " (" << points << "):</strong></dt><dd>";

      display_question(form, tran, dataset_id, problem_id, q_ord, language_id);

      if (!correct)
        {
          form << "<p><strong>";
          if (user_answer.empty())
            form << t_missing_answer;
          else
            form << t_wrong_answer;
          form << "</strong></p>";
        }

      form << "<pre>" << user_answer << "</pre>";

      if (!correct)
        {
          form << "<p><strong>"
               << t_correct_answer
               << "</strong></p>";

          result answ(tran.exec("SELECT answer "
                                "  FROM answers "
                                "       NATURAL JOIN "
                                "       problems "
                                " WHERE problem_id = " + problem_id +
				"   AND dataset_id = " + dataset_id +
                                " ORDER BY priority ASC" ));
          for (result::const_iterator b=answ.begin(), e=answ.end(); b!=e; b++)
            {
              const string corr_answer = b[0].as(string());
              form << "<pre>" << corr_answer << "</pre>";
            }
        }

      form << "<dd>";
    }
  form << "</dl>";

}


void SQLtutor::display_question(Form& form, pqxx::work& tran,
                                std::string dataset_id,
                                std::string problem_id,
                                std::string q_ord,
                                std::string language_id)
{
  using namespace pqxx;
  using std::string;
  result res2(tran.exec("SELECT dataset, points, question "
                        "  FROM questions "
                        "       NATURAL JOIN problems "
                        "       NATURAL JOIN datasets "
                        " WHERE dataset_id  = " + dataset_id +
                        "   AND problem_id  = " + problem_id +
                        "   AND q_ord       = " + q_ord +
                        "   AND language_id = '" + language_id + "' "
                        ));
  result::const_iterator q = res2.begin();
  if (q == res2.end()) { form << " THROW "; throw "..."; }

  string dataset  = q[0].as(string());
  string points   = q[1].as(string());
  string text     = q[2].as(string());

  result res3(tran.exec("SELECT ds_table, columns "
                        "  FROM datasets "
                        "       NATURAL JOIN dataset_tables "
                        " WHERE dataset_id = '" + dataset_id + "' "
                        " ORDER BY dt_ord; " ));
  if (res3.empty()) throw "...";

  Table datab(2, "border='1'");
  datab.th(t_table);
  datab.th(t_columns);
  for (result::const_iterator b=res3.begin(), e=res3.end(); b!=e; b++)
    {
      datab << b[0].as(string()) << b[1].as(string());
    }
  form << datab;

  form << (Par() << text);
}
