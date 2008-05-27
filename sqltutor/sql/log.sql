DROP TABLE sessions CASCADE;

CREATE TABLE sessions (
   session_id serial PRIMARY KEY,
   login      varchar(20),
   password   varchar(20),
   points_min integer,
   points_max integer,
   dataset    varchar(12),
   help       boolean NOT NULL DEFAULT false,
   host       inet,
   time       timestamp,
   status     varchar(6) NOT NULL DEFAULT 'open' 
              CHECK (status IN ('open', 'closed'))
);


DROP TABLE sessions_answers CASCADE;

CREATE TABLE sessions_answers (
   session_id  integer REFERENCES sessions,
   question_id integer NOT NULL,
   answer      text,
   correct     boolean DEFAULT false,
   time        timestamp     
);

