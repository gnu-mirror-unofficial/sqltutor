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
 * $Id: settings.cpp,v 1.4 2009/02/17 15:20:32 cepek Exp $ 
 */

#include "sqltutor.h"
#include "config.h"

typedef const std::string T;

#define str(s)  # s
#define xstr(s) str(s)

/********************************************************************/
/*                                                                  */
/* user settings                                                    */
/*                                                                  */
/********************************************************************/

T SQLtutor::db_connection     = " dbname="   xstr(SQLTUTOR_DATABASE)
                                " host=localhost"
                                " user="     xstr(SQLTUTOR_WWW_USER)
                                " password=" xstr(SQLTUTOR_PASSWORD);
T SQLtutor::db_connection_sql = " dbname="   xstr(SQLTUTOR_DATABASE)
                                " host=localhost"
                                " user="     xstr(SQLTUTOR_WWW_EXEC)
                                " password=" xstr(SQLTUTOR_PASSEXEC);
T SQLtutor::title             = "SQL tutor";
T SQLtutor::init_continue     = "Continue";
T SQLtutor::init_datasets     = "Display datasets";
T SQLtutor::init_manual       = "Online manual";
T SQLtutor::main_stop         = "Finish test";
T SQLtutor::main_next         = "Next question";
T SQLtutor::main_help         = "Help";
T SQLtutor::main_data         = "Display data";
T SQLtutor::main_sql          = "Execute SQL";
T SQLtutor::remaining_rows    = "Remaining rows not displayed ...";
T SQLtutor::new_test          = "New test";
T SQLtutor::test_finished     = "Test finished ...";
T SQLtutor::t_tutorial        = "Tutorial";
T SQLtutor::t_user            = "User";
T SQLtutor::t_password        = "Password";
T SQLtutor::t_points_min      = "Min points";
T SQLtutor::t_points_max      = "Max points";
T SQLtutor::t_dataset         = "Dataset";
T SQLtutor::t_help            = "Help";
T SQLtutor::t_table           = "Table";
T SQLtutor::t_columns         = "Columns";
T SQLtutor::t_bad_value_min   = "Bad value min";
T SQLtutor::t_bad_value_max   = "Bad value max";
T SQLtutor::t_correct_answer  = "Correct answer";
T SQLtutor::t_wrong_answer    = "Wrong answer";
T SQLtutor::t_missing_answer  = "Missing answer";
T SQLtutor::t_permutation     = "results differ in column permutaion";
T SQLtutor::t_unmatched_cols  = "Unmatched number of columns";
T SQLtutor::t_unmatched_rows  = "Unmatched number of rows";
T SQLtutor::t_should_be       = "should be";
T SQLtutor::t_stopped_done    = "all questions asked";
T SQLtutor::t_stopped_failed  = "database connection failed";
T SQLtutor::t_sql_error       = "error on SQL execution";
T SQLtutor::t_nmbr_questions  = "Number of questions";
T SQLtutor::t_nmbr_cor_answs  = "Correct answers";
T SQLtutor::t_total_points    = "Total points";
T SQLtutor::t_evaluation      = "Evaluation";
T SQLtutor::t_help_on         = "Help was on during the test";
T SQLtutor::t_unknown_state   = "unknown internal state";
T SQLtutor::t_session         = "session ";
T SQLtutor::t_session_unknown = "Unknown session ID ... ";
T SQLtutor::t_session_closed  = "Session has been already closed ... ";
T SQLtutor::t_select_tutorial = "Please, select tutorial first ... ";
T SQLtutor::t_no_datasets     = "No datasets available ... ";
T SQLtutor::t_empty_set       = "empty set";
T SQLtutor::t_welcome         = "Welcome to GNU Sqltutor";


/********************************************************************/
/*                                                                  */
/* program settings                                                 */
/*                                                                  */
/********************************************************************/

T SQLtutor::version       =  VERSION;
T SQLtutor::action        = CGI::getenv("SCRIPT_NAME");
T SQLtutor::init_state    = "";      // init state is defined as empty
T SQLtutor::main_state    = "main_state";
