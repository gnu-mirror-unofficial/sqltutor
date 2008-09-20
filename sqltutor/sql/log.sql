CREATE TABLE sqltutor.tutorials (
   tutorial_id serial PRIMARY KEY,
   language    varchar(3),
   tutorial    varchar(12),
   UNIQUE (language, tutorial)
);


CREATE TABLE sqltutor.sessions (
   session_id  serial PRIMARY KEY,
   tutorial_id integer,            -- REFERENCES sqltutor.tutorials,
   login       varchar(20),
   password    varchar(20),
   points_min  integer,
   points_max  integer,
   dataset     varchar(12),
   help        boolean NOT NULL DEFAULT false,
   host        inet,
   time        timestamp,
   status      varchar(6) NOT NULL DEFAULT 'open' 
               CHECK (status IN ('open', 'closed'))
);


CREATE TABLE sqltutor.sessions_answers (
   session_id  integer REFERENCES sqltutor.sessions,
   question_id integer NOT NULL,
   answer      text,
   correct     boolean DEFAULT false,
   time        timestamp     
);


