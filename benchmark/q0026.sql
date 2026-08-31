WITH actor_credits AS
  (SELECT person_id,
          movie_id
   FROM cast_info
   WHERE role_id IN (1,
                     2)),
     credit_counts AS
  (SELECT person_id,
          count(*) AS n_credits
   FROM actor_credits
   GROUP BY person_id),
     actor_genres AS
  (SELECT DISTINCT ac.person_id,
                   mi.info AS genre
   FROM actor_credits ac
   JOIN movie_info mi ON mi.movie_id = ac.movie_id
   AND mi.info_type_id = 3),
     genre_counts AS
  (SELECT person_id,
          count(*) AS n_genres
   FROM actor_genres
   GROUP BY person_id)
SELECT corr(c.n_credits, g.n_genres) AS correlation,
       count(*) AS n_actors
FROM credit_counts c
JOIN genre_counts g ON g.person_id = c.person_id;
