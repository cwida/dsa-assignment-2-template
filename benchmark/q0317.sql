SELECT (t.production_year/10)*10 AS decade,
       count(*) c
FROM cast_info ci
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN title t ON ci.movie_id = t.id
WHERE cn.name IN ('Count Dracula',
                  'Dracula')
GROUP BY decade
ORDER BY c DESC
LIMIT 15;
