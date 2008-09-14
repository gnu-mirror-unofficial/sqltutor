CREATE TABLE sqltutor.collections (
   collection_id serial PRIMARY KEY,
   language      varchar(3),
   collection    varchar(12),
   UNIQUE (language, collection)
);


CREATE TABLE sqltutor.sessions (
   session_id    serial PRIMARY KEY,
   collection_id integer,            -- REFERENCES sqltutor.collections,
   login         varchar(20),
   password      varchar(20),
   points_min    integer,
   points_max    integer,
   dataset       varchar(12),
   help          boolean NOT NULL DEFAULT false,
   host          inet,
   time          timestamp,
   status        varchar(6) NOT NULL DEFAULT 'open' 
                 CHECK (status IN ('open', 'closed'))
);


CREATE TABLE sqltutor.sessions_answers (
   session_id  integer REFERENCES sqltutor.sessions,
   question_id integer NOT NULL,
   answer      text,
   correct     boolean DEFAULT false,
   time        timestamp     
);


