SELECT COUNT(DISTINCT ci.movie_id) AS distinct_movies,
       COUNT(*) AS ROWS
FROM cast_info ci
WHERE ci.person_id = 809234
  AND ci.role_id = 8;
