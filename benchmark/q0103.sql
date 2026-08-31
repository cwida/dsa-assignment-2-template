SELECT n.name, count(*) AS n_credits
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
JOIN kind_type kt ON kt.id = t.kind_id
JOIN name n ON n.id = ci.person_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE t.production_year BETWEEN 2001 AND 2011
  AND kt.kind IN ('episode', 'movie')
  AND EXISTS (SELECT 1 FROM movie_info mif JOIN info_type itf ON itf.id = mif.info_type_id WHERE mif.movie_id = t.id AND itf.info = 'genres' AND mif.info = 'Adult')
GROUP BY n.name
ORDER BY n_credits DESC, n.name
LIMIT 20;
