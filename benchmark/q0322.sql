SELECT n.name,
       count(*) c,
       min(t.production_year) miny,
       max(t.production_year) maxy
FROM cast_info ci
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN title t ON ci.movie_id = t.id
JOIN name n ON ci.person_id = n.id
WHERE cn.name IN ('Count Dracula',
                  'Dracula')
GROUP BY n.name
ORDER BY c DESC
LIMIT 15;
