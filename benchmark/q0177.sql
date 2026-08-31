SELECT coalesce(n.gender, 'unknown') AS gender, count(DISTINCT ci.person_id) AS n_people
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
JOIN kind_type kt ON kt.id = t.kind_id
JOIN name n ON n.id = ci.person_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE t.production_year BETWEEN 1880 AND 2019
  AND kt.kind IN ('episode', 'movie', 'video movie', 'tv movie', 'tv series', 'video game')
GROUP BY 1
ORDER BY n_people DESC;
