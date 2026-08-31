SELECT cn.country_code,
       COUNT(DISTINCT ci.movie_id) AS n_movies
FROM cast_info ci
JOIN movie_companies mc ON mc.movie_id = ci.movie_id
AND mc.company_type_id = 2
JOIN company_name cn ON cn.id = mc.company_id
WHERE ci.person_id = 809234
  AND ci.role_id = 8
GROUP BY cn.country_code
ORDER BY n_movies DESC;
