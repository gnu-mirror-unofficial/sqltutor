/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008  Ales Cepek <cepek@gnu.org>
 
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

/* 
 * $Id: display_answers.h,v 1.3 2009/02/18 19:16:59 cepek Exp $ 
 */

#ifndef __h___SQLTUTOR_H___display_answers_h___Display_Answers
#define __h___SQLTUTOR_H___display_answers_h___Display_Answers

#include <pqxx/pqxx>
#include <string>
#include "sqltutor.h"

template <typename Form>
void SQLtutor::display_answers(Form& form, 
                               pqxx::work& tran, std::string session_id)
{
  using namespace pqxx;
  using std::string;

  form << "<br/>";

  string query1 =
    "SELECT sa.tutorial_id, sa.question_id, q.points, sa.correct, "
    "       sa.answer AS user_answer, s.help, a.answer AS corr_answer "
    "  FROM sessions_answers AS sa"
    "       JOIN "
    "       questions AS q"
    "       ON sa.tutorial_id = q.tutorial_id AND sa.question_id=q.id "
    "       JOIN "
    "       sessions AS s "
    "       ON sa.session_id = s.session_id "
    "       JOIN "
    "       answers AS a"
    "       ON sa.question_id=a.question_id AND sa.tutorial_id=a.tutorial_id "
    "          AND a.priority=1 "
    " WHERE sa.session_id=" + session_id + " "
    " ORDER BY sa.time ASC ";

  form << "<dl>";
  bool first = true;
  result res1(tran.exec(query1));
  for (result::const_iterator r=res1.begin(), e=res1.end(); r!=e; ++r)
    {
      const string tutorial_id = r[0].as(string());
      const string question_id = r[1].as(string());
      int               points = r[2].as(int());
      bool             correct = r[3].as(bool());
      const string user_answer = r[4].as(string());
      bool                help = r[5].as(bool());
      const string corr_answer = r[6].as(string());
      
      if (first && help)
        form << "<p><strong style='color:red'>" + t_help_on + "</strong></p>";
      first = false;

      form << "<dt style='color:"
           << (correct ? "green" : "red'")
           << "';><strong>" << question_id 
           << " (" << points << "):</strong></dt><dd>";

      display_question(form, tran, tutorial_id, question_id);

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

          form << "<pre>" << corr_answer << "</pre>";
        }

      form << "<dd>";
    }
  form << "</dl>";

}


template<typename Form> 
void SQLtutor::display_question(Form& form, pqxx::work& tran, 
                                std::string tutorial_id,
                                std::string question_id)
{
  using namespace pqxx;
  using std::string;

  result res2(tran.exec("SELECT dataset, points, question "
                        "  FROM questions "
                        " WHERE tutorial_id = " + tutorial_id +
                        "   AND id = " + question_id + ";" ));
  result::const_iterator q = res2.begin();
  if (q == res2.end()) throw "...";
  
  string dataset  = q[0].as(string());
  string points   = q[1].as(string());
  string text     = q[2].as(string());
  
  result res3(tran.exec("SELECT ds_table, columns "
                        "  FROM datasets "
                        " WHERE dataset = '" + dataset + "' "
                        " ORDER BY ord; " ));
  if (res3.empty()) throw "...";
  
  form << "<table border='1'><tr><th>" + t_table + "</th>"
       << "<th>" + t_columns + "</th></tr>";
  for (result::const_iterator b=res3.begin(), e=res3.end(); b!=e; b++)
    {
      form << "<tr>"
           << "<td> &nbsp; " << b[0].as(string()) << " &nbsp; </td>"
           << "<td> &nbsp; " << b[1].as(string()) << " &nbsp; </td></tr>";
    }
  form << "</table>";
  
  form << "<p>" << text << "</p>";
}


#endif
