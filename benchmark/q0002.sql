SELECT c1.name AS company1,
       c2.name AS company2,
       count(*) AS shared_movies
FROM movie_companies mc1
JOIN movie_companies mc2 ON mc1.movie_id = mc2.movie_id
AND mc1.company_id < mc2.company_id
JOIN title t ON t.id = mc1.movie_id
JOIN company_name c1 ON c1.id = mc1.company_id
JOIN company_name c2 ON c2.id = mc2.company_id
WHERE t.production_year BETWEEN 1990 AND 2010
GROUP BY c1.name,
         c2.name
HAVING count(*) >= 20
ORDER BY shared_movies DESC
LIMIT 30;
