SELECT COUNT(DISTINCT ci.movie_id)
FROM cast_info ci
LEFT JOIN movie_companies mc ON mc.movie_id = ci.movie_id
AND mc.company_type_id = 2
WHERE ci.person_id = 809234
  AND ci.role_id = 8
  AND mc.id IS NULL;
