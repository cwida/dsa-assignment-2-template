SELECT t.production_year,
       count(*) AS n
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
WHERE ci.person_id = 1685591
GROUP BY t.production_year
ORDER BY n DESC
LIMIT 10;
