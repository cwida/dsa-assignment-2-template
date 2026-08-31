SELECT t.production_year AS year, count(DISTINCT ci.person_id) AS n_people
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
JOIN kind_type kt ON kt.id = t.kind_id
JOIN name n ON n.id = ci.person_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE t.production_year BETWEEN 1880 AND 2019
  AND kt.kind IN ('episode', 'movie', 'video movie', 'tv movie', 'tv series', 'video game')
  AND EXISTS (SELECT 1 FROM movie_info mif JOIN info_type itf ON itf.id = mif.info_type_id WHERE mif.movie_id = t.id AND itf.info = 'genres' AND mif.info = 'Short')
  AND rt.role IN ('actor')
GROUP BY t.production_year
ORDER BY t.production_year;
