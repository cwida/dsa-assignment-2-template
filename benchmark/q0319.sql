SELECT t.title,
       t.production_year,
       count(*) c
FROM cast_info ci
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN title t ON ci.movie_id = t.id
WHERE cn.name IN ('Count Dracula',
                  'Dracula')
  AND t.production_year BETWEEN 1970 AND 1979
GROUP BY t.title,
         t.production_year
ORDER BY c DESC
LIMIT 20;
