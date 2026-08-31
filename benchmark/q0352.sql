WITH india_movies AS
  (SELECT DISTINCT movie_id
   FROM movie_info
   WHERE info_type_id=8
     AND info='India')
SELECT n.id,
       n.name,
       count(DISTINCT ci.movie_id) AS n_movies
FROM cast_info ci
JOIN india_movies im ON ci.movie_id = im.movie_id
JOIN name n ON n.id = ci.person_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE rt.role IN ('actor',
                  'actress')
GROUP BY n.id,
         n.name
ORDER BY n_movies DESC
LIMIT 10;
