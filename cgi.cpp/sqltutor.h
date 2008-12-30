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
 * $Id: sqltutor.h,v 1.4 2008/12/30 18:49:21 cepek Exp $ 
 */

#ifndef __h___SQLTUTOR_H___sqltutor_h___SQLtutor
#define __h___SQLTUTOR_H___sqltutor_h___SQLtutor

#include <iostream>
#include <exception>
#include <pqxx/pqxx>
#include "cgi.h"


/** \brief SQL tutorial implementaion.
 */

class SQLtutor {
public:

  SQLtutor();
  ~SQLtutor();

  void run();
  
  template<typename Form> static void 
  display_answers(Form&,  pqxx::work& tran, std::string session_id);

  template<typename Form> static void 
  display_question(Form&,  pqxx::work& tran, 
                   std::string tutorial_id, std::string question_id);

private:

  // user settings

  static const std::string db_connection;
  static const std::string db_connection_sql;
  static const std::string state;
  static const std::string init_continue;
  static const std::string init_datasets;
  static const std::string main_stop;
  static const std::string main_next;
  static const std::string main_help;
  static const std::string main_data;
  static const std::string main_sql;
  static const std::string remaining_rows;
  static const std::string new_test;
  static const std::string test_finished;
  static const std::string t_tutorial;
  static const std::string t_user;
  static const std::string t_password;
  static const std::string t_points_min;
  static const std::string t_points_max;
  static const std::string t_dataset;
  static const std::string t_help;
  static const std::string t_table;
  static const std::string t_columns;
  static const std::string t_bad_value_min;
  static const std::string t_bad_value_max;
  static const std::string t_correct_answer;
  static const std::string t_wrong_answer;
  static const std::string t_missing_answer;
  static const std::string t_permutation;
  static const std::string t_unmatched_cols;
  static const std::string t_unmatched_rows;
  static const std::string t_should_be;
  static const std::string t_stopped_done;
  static const std::string t_stopped_failed;
  static const std::string t_sql_error;
  static const std::string t_nmbr_questions;
  static const std::string t_nmbr_cor_answs;
  static const std::string t_total_points;
  static const std::string t_evaluation;
  static const std::string t_help_on;
  static const std::string t_unknown_state;
  static const std::string t_session;
  static const std::string t_session_unknown;
  static const std::string t_session_closed;
  static const std::string t_select_tutorial;
  static const std::string t_no_datasets;
  static const std::string t_empty_set;

  // program settings

  static const std::string version;
  static const std::string title;
  static const std::string action;
  static const std::string init_state;
  static const std::string main_state;

  class Exception : public std::exception   
  {
  public:
    const char* what() { return "SQLtutor : Base Exception";     }
  };
  
  class AllQuestionsDone : public Exception 
  {
    const char* what() { return "SQLtutor : All Questions Done"; }
  };

  CGI           cgi;
  Form          form;
  size_t        sql_result_size; 
  size_t        sql_result_columns; 
  size_t        sql_tutor_size;
  size_t        sql_tutor_columns;
  bool          correct_answer;
  bool          first_permutation;
  std::string   sql;
  std::string   sql_checked;
  std::string   tutorial_id;
  std::string   question_id;
  std::string   answered;
  std::string   session_id;
  std::string   hash;

  void form_init();
  void form_main();
  void form_stop();

  void check_answer    (pqxx::work& transaction);
  void submit_sql      (pqxx::work& transaction);
  void show_table_data (pqxx::work& transaction);
  void get_new_question(pqxx::work& transaction);
  void save_answer     (pqxx::work& transaction);
  void set_schema      (pqxx::work& transaction)
  {
    transaction.exec("SET search_path TO sqltutor;");
  }

  void show_sql_result  ();
  void show_datasets    ();
  std::string button_sep() { return "&nbsp;&nbsp;&nbsp;&nbsp;"; }
  bool empty            (std::string);

  std::string tutorial_selection();
};


#endif
