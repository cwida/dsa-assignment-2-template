SELECT t.id,
       t.title,
       t.production_year
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
WHERE ci.person_id = 809234
  AND ci.role_id = 8
ORDER BY t.production_year;
