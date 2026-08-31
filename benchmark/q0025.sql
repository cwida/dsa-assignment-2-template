WITH actor_credits AS
  (SELECT person_id,
          movie_id
   FROM cast_info
   WHERE role_id IN (1,
                     2)),
     credit_counts AS
  (SELECT person_id,
          count(*) AS n_credits,
          count(DISTINCT movie_id) AS n_movies
   FROM actor_credits
   GROUP BY person_id),
     actor_genres AS
  (SELECT DISTINCT ac.person_id,
                   mi.info AS genre
   FROM actor_credits ac
   JOIN movie_info mi ON mi.movie_id = ac.movie_id
   AND mi.info_type_id = 3)
SELECT n.name,
       g.person_id,
       count(*) AS n_genres,
       c.n_credits,
       c.n_movies
FROM actor_genres g
JOIN credit_counts c ON c.person_id = g.person_id
JOIN name n ON n.id = g.person_id
GROUP BY n.name,
         g.person_id,
         c.n_credits,
         c.n_movies
ORDER BY n_genres DESC,
         c.n_credits DESC
LIMIT 30;
