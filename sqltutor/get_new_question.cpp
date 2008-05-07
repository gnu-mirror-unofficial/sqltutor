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
 * $Id: get_new_question.cpp,v 1.1 2008/05/07 15:27:34 cepek Exp $ 
 */

#include "sqltutor.h"

void SQLtutor::get_new_question(pqxx::work& tran) 
{
  using pqxx::result;

  result res1(tran.exec("SELECT next_question(" + session_id + ")" ));
  if (res1.begin()[0].is_null())
    {
      question_id.clear();
      throw AllQuestionsDone();
    }

  question_id = res1.begin()[0].as(std::string());

  using namespace pqxx;
  connection c( db_connection );
  work       t(c, "transaction-get-new-question");
  result     r(t.exec("INSERT INTO sessions_answers "
                      "(session_id, question_id, time) VALUES (" 
                      + session_id + ", " + question_id + ", now() )" ));
  t.commit();
}
