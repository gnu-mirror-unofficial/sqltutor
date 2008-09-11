/* next question for the given session number
 * ------------------------------------------      
 */


DROP   FUNCTION next_question(IN session_id_ integer, IN hash_ char(32));

CREATE FUNCTION next_question(IN session_id_ integer, IN hash_ char(32))
RETURNS integer
AS $$
DECLARE
   next_question_ integer;
   s_dataset_     varchar(20);
   s_status_      varchar(6);
   s_points_min_  integer;
   s_points_max_  integer;
   s_help_        boolean;
   max_points_    integer;
   a_count_       integer;
BEGIN
   SELECT points_min, points_max, dataset, status 
     INTO s_points_min_, s_points_max_, s_dataset_, s_status_
     FROM sessions
    WHERE session_id=session_id_ 
      AND hash_ = md5(time);


   IF s_points_min_ IS NULL AND 
      s_points_max_ IS NULL AND 
      s_dataset_    IS NULL
   THEN
      /* algorithm 2 */

      SELECT coalesce(max(points),1) INTO max_points_
        FROM questions
             JOIN
             sessions_answers
             ON (id = question_id)
       WHERE session_id = session_id_;

      IF max_points_ < 5 THEN

         SELECT count(*) INTO a_count_
           FROM questions
                JOIN
                sessions_answers
                ON (id = question_id)
          WHERE session_id = session_id_
            AND correct
            AND points = max_points_;
         
         IF a_count_ >= max_points_ THEN
            max_points_ := max_points_ + 1;
         END IF;

         s_points_min_ := max_points_;  

         SELECT id INTO next_question_
           FROM (SELECT id, points, random() AS rand
                   FROM questions
                  WHERE (s_dataset_ IS NULL OR s_dataset_ = dataset) AND
                        (s_points_min_ IS NULL OR s_points_min_ <= points) AND
                        (s_status_ = 'open') AND
                        (id NOT IN (SELECT question_id 
                                        FROM sessions_answers
                                       WHERE session_id=session_id_))
                  ORDER BY points ASC, rand
                  LIMIT 1) next;
         
         RETURN next_question_;
      END IF;

      /* for points >=5 continue with algoritm 1 */
      s_points_min_ := 5;       

   END IF;


   /* algorithm 1 */

   SELECT id INTO next_question_
     FROM (SELECT q.id, random() AS rand
             FROM questions AS q
            WHERE (s_dataset_ IS NULL OR s_dataset_ = q.dataset) AND
                  (s_points_min_ IS NULL OR s_points_min_ <= q.points) AND
                  (s_points_max_ IS NULL OR s_points_max_ >= q.points) AND
                  (s_status_ = 'open') AND
                  (id NOT IN (SELECT question_id 
                                  FROM sessions_answers
                                 WHERE session_id=session_id_))
            ORDER BY rand
            LIMIT 1) next;

   RETURN next_question_;
END;
$$ LANGUAGE plpgsql;



/* version 1

DROP   FUNCTION next_question(integer, char(32));

CREATE FUNCTION next_question(integer, char(32))  -- session_id, hash
RETURNS integer
AS $$
SELECT id
  FROM (SELECT q.id, random() AS rand
          FROM questions as q
               JOIN
               (SELECT * 
                  FROM sessions 
                 WHERE session_id=$1 
                   AND $2 = md5(time)
               ) AS s
               ON (q.id NOT IN (SELECT question_id 
                                  FROM sessions_answers
                                 WHERE session_id=$1)) AND
                  (s.dataset IS NULL OR q.dataset=s.dataset) AND
                  (s.points_min IS NULL OR s.points_min <= q.points) AND
                  (s.points_max IS NULL OR s.points_max >= q.points) AND
                  (s.status = 'open')
         ORDER BY rand
         LIMIT 1) next;
$$ LANGUAGE SQL;

*/
