SELECT rt.role, count(*) AS n_credits
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
JOIN kind_type kt ON kt.id = t.kind_id
JOIN name n ON n.id = ci.person_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE t.production_year BETWEEN 1880 AND 2019
  AND kt.kind IN ('episode', 'movie', 'video movie', 'tv movie', 'tv series', 'video game')
GROUP BY rt.role
ORDER BY n_credits DESC, rt.role;
