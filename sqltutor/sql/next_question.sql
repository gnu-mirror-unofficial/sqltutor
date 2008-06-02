/* next question for the given session number
 * ------------------------------------------      
 */

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

