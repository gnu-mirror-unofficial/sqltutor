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


DROP   SCHEMA sqltutor CASCADE;
CREATE SCHEMA sqltutor;
DROP   SCHEMA sqltutor_data CASCADE;
CREATE SCHEMA sqltutor_data;

-- language codes in ISO 639-1
CREATE TABLE sqltutor.languages (
   language_id char(2) PRIMARY KEY,
   language    varchar(30) NOT NULL
);

-- examples of some languages
INSERT INTO sqltutor.languages VALUES('bg', 'Bulgarian');
INSERT INTO sqltutor.languages VALUES('ca', 'Catalan');
INSERT INTO sqltutor.languages VALUES('cs', 'Czech');
INSERT INTO sqltutor.languages VALUES('da', 'Danish');
INSERT INTO sqltutor.languages VALUES('de', 'German');
INSERT INTO sqltutor.languages VALUES('el', 'Greek');
INSERT INTO sqltutor.languages VALUES('en', 'English');
INSERT INTO sqltutor.languages VALUES('es', 'Spanish');
INSERT INTO sqltutor.languages VALUES('et', 'Estonian');
INSERT INTO sqltutor.languages VALUES('fi', 'Finnish');
INSERT INTO sqltutor.languages VALUES('fr', 'French');
INSERT INTO sqltutor.languages VALUES('hr', 'Croatian');
INSERT INTO sqltutor.languages VALUES('hu', 'Hungarian');
INSERT INTO sqltutor.languages VALUES('it', 'Italian');
INSERT INTO sqltutor.languages VALUES('ja', 'Japanese');
INSERT INTO sqltutor.languages VALUES('nl', 'Dutch');
INSERT INTO sqltutor.languages VALUES('no', 'Norwegian');
INSERT INTO sqltutor.languages VALUES('pl', 'Polish');
INSERT INTO sqltutor.languages VALUES('pt', 'Portuguese');
INSERT INTO sqltutor.languages VALUES('ro', 'Romanian');
INSERT INTO sqltutor.languages VALUES('ru', 'Russian');
INSERT INTO sqltutor.languages VALUES('sk', 'Slovak');
INSERT INTO sqltutor.languages VALUES('sl', 'Slovenian');
INSERT INTO sqltutor.languages VALUES('sv', 'Swedish');
INSERT INTO sqltutor.languages VALUES('vi', 'Vietnamese');
INSERT INTO sqltutor.languages VALUES('zh', 'Chinese');
INSERT INTO sqltutor.languages VALUES('zu', 'Zulu');


CREATE TABLE sqltutor.tutorials (
   tutorial_id serial PRIMARY KEY,
   tutorial    varchar(40) NOT NULL,
   language_id char(2) NOT NULL REFERENCES sqltutor.languages,
   t_ord       integer NOT NULL DEFAULT 0
);


CREATE TABLE sqltutor.datasets (
   dataset_id serial PRIMARY KEY,
   dataset    varchar(40) NOT NULL UNIQUE
);


CREATE TABLE sqltutor.sessions (
   session_id  serial  PRIMARY KEY,
   tutorial_id integer REFERENCES sqltutor.tutorials,
   login       varchar(20),
   password    varchar(20),
   points_min  integer NOT NULL DEFAULT 0,
   points_max  integer NOT NULL DEFAULT 0,
   ds_id       integer REFERENCES sqltutor.datasets (dataset_id),
   help        integer NOT NULL DEFAULT 0 CHECK (help in (0, 1)),
   algorithm   integer NOT NULL DEFAULT 1 CHECK (algorithm > 0),
   host        inet,
   start       timestamp NOT NULL,
   stop        timestamp,
   is_open     integer NOT NULL DEFAULT 1
                          CHECK (is_open IN (0, 1))
);


CREATE TABLE sqltutor.problems (
   dataset_id integer REFERENCES sqltutor.datasets,
   problem_id integer CHECK (problem_id > 0),
   points     integer NOT NULL CHECK (points > 0),
   PRIMARY KEY (dataset_id, problem_id)
);


CREATE TABLE sqltutor.tutorials_problems (
   tutorial_id integer,
   dataset_id  integer, 
   problem_id  integer,
   PRIMARY KEY (tutorial_id, dataset_id, problem_id),
   FOREIGN KEY (dataset_id, problem_id) REFERENCES sqltutor.problems
);


CREATE TABLE sqltutor.questions (
   dataset_id  integer,
   problem_id  integer,
   q_ord       integer,
   language_id char(2) NOT NULL REFERENCES sqltutor.languages,
   question    text    NOT NULL,
   PRIMARY KEY (dataset_id, problem_id, q_ord, language_id),
   FOREIGN KEY (dataset_id, problem_id) REFERENCES sqltutor.problems
);


CREATE TABLE sqltutor.sessions_questions (
   session_id  integer REFERENCES sqltutor.sessions,
   dataset_id  integer,
   problem_id  integer,
   q_ord       integer,
   language_id char(2),
   answer      text    NOT NULL DEFAULT '',
   correct     integer DEFAULT 0 CHECK (correct IN (0, 1)),
   time        timestamp NOT NULL,
   PRIMARY KEY (session_id, dataset_id, problem_id, q_ord, language_id),
   FOREIGN KEY (dataset_id, problem_id, q_ord, language_id)
               REFERENCES sqltutor.questions 
);


CREATE TABLE sqltutor.answers (
   dataset_id   integer,
   problem_id   integer,
   priority     integer NOT NULL CHECK (priority > 0),
   answer       text    NOT NULL DEFAULT '',
   PRIMARY KEY (dataset_id, problem_id, priority),
   FOREIGN KEY (dataset_id, problem_id) REFERENCES sqltutor.problems
);


CREATE TABLE sqltutor.categories (
   category_id integer PRIMARY KEY,
   category    varchar(40) UNIQUE
);


CREATE TABLE sqltutor.problems_categories (
   dataset_id   integer REFERENCES sqltutor.categories,
   problem_id   integer,
   category_id  integer REFERENCES sqltutor.categories,
   PRIMARY KEY (dataset_id, problem_id, category_id),
   FOREIGN KEY (dataset_id, problem_id) REFERENCES sqltutor.problems
);


CREATE TABLE sqltutor.dataset_tables (
  dataset_id integer REFERENCES sqltutor.datasets,
  dt_ord     integer NOT NULL DEFAULT 0,
  ds_table   varchar(40) NOT NULL,
  columns    varchar(1000) NOT NULL,
  PRIMARY KEY (dataset_id, dt_ord)
);


CREATE TABLE sqltutor.dataset_sources (
  dataset_id integer REFERENCES sqltutor.datasets,
  year       integer,
  source     varchar(120),
  PRIMARY KEY (dataset_id, year, source)
);
