/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008  Free Software Foundation, Inc.
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


CREATE TABLE sqltutor.tutorials (
   tutorial_id serial PRIMARY KEY,
   language    varchar(20),
   tutorial    varchar(20),
   label       varchar(12) UNIQUE,
   ord         integer DEFAULT 0
);


CREATE TABLE sqltutor.sessions (
   session_id  serial  PRIMARY KEY,
   tutorial_id integer REFERENCES sqltutor.tutorials,
   login       varchar(20),
   password    varchar(20),
   points_min  integer,
   points_max  integer,
   dataset     varchar(21),
   help        boolean NOT NULL DEFAULT false,
   host        inet,
   time        timestamp,
   status      varchar(6) NOT NULL DEFAULT 'open' 
               CHECK (status IN ('open', 'closed'))
);


CREATE TABLE sqltutor.questions (
   tutorial_id  integer REFERENCES sqltutor.tutorials(tutorial_id),
   id           integer,
   dataset      VARCHAR(20),
   points       integer,
   question     TEXT,
   PRIMARY KEY (tutorial_id, id)
);


CREATE TABLE sqltutor.sessions_answers (
   session_id  integer REFERENCES sqltutor.sessions,
   tutorial_id integer, 
   question_id integer,
   answer      text,
   correct     boolean DEFAULT false,
   time        timestamp,
   PRIMARY KEY (session_id, tutorial_id, question_id),
   FOREIGN KEY (tutorial_id, question_id) 
               REFERENCES
               sqltutor.questions(tutorial_id, id)
);


CREATE TABLE sqltutor.answers (
   tutorial_id  integer,
   question_id  integer,
   priority     integer,
   answer       TEXT,
   PRIMARY KEY (tutorial_id, question_id, priority),
   FOREIGN KEY (tutorial_id, question_id) 
               REFERENCES
               sqltutor.questions(tutorial_id, id)
);


CREATE TABLE sqltutor.categories (
   id        integer PRIMARY KEY,
   category  VARCHAR(20) UNIQUE
);


CREATE TABLE sqltutor.questions_categories (
   tutorial_id  integer,
   question_id  integer,
   category_id  integer,
   PRIMARY KEY (tutorial_id, question_id, category_id),
   FOREIGN KEY (tutorial_id, question_id)
               REFERENCES
               sqltutor.questions(tutorial_id, id)
);


CREATE TABLE sqltutor.datasets (
  dataset   VARCHAR(21),
  ord       INT,
  ds_table  VARCHAR(20) NOT NULL,
  columns   VARCHAR(65) NOT NULL,
  PRIMARY KEY (dataset, ord)
);


CREATE TABLE sqltutor.dataset_sources (
  dataset   VARCHAR(21) PRIMARY KEY,
  year      INT,
  sources   VARCHAR(120)
);
