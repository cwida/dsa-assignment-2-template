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
   GROUP BY person_id),
     joined AS
  (SELECT c.n_credits,
          g.n_genres
   FROM credit_counts c
   JOIN genre_counts g ON g.person_id = c.person_id)
SELECT CASE
           WHEN n_credits = 1 THEN '1'
           WHEN n_credits BETWEEN 2 AND 5 THEN '2-5'
           WHEN n_credits BETWEEN 6 AND 20 THEN '6-20'
           WHEN n_credits BETWEEN 21 AND 50 THEN '21-50'
           WHEN n_credits BETWEEN 51 AND 150 THEN '51-150'
           ELSE '150+'
       END AS credit_bucket,
       count(*) AS n_actors,
       round(avg(n_genres), 2) AS avg_genres,
       max(n_genres) AS max_genres
FROM joined
GROUP BY 1
ORDER BY min(n_credits);
