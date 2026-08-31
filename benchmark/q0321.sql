SELECT cn.id,
       cn.name,
       count(*) c
FROM cast_info ci
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
WHERE n.name = 'Freeman, Morgan'
  AND cn.name ILIKE '%dracula%'
GROUP BY cn.id,
         cn.name;
