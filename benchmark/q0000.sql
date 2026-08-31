SELECT cn.name,
       count(DISTINCT mc.movie_id) AS num_movies
FROM movie_companies mc
JOIN title t ON mc.movie_id = t.id
JOIN company_name cn ON mc.company_id = cn.id
WHERE t.production_year BETWEEN 1995 AND 2005
GROUP BY cn.name
ORDER BY num_movies DESC
LIMIT 10;
