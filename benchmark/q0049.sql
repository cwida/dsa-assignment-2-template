SELECT n.id,
       n.name,
       count(DISTINCT mi.info) AS num_countries
FROM cast_info ci
JOIN name n ON n.id = ci.person_id
JOIN movie_info mi ON mi.movie_id = ci.movie_id
AND mi.info_type_id = 8
WHERE ci.role_id IN (1,
                     2)
GROUP BY n.id,
         n.name
ORDER BY num_countries DESC
LIMIT 20;
