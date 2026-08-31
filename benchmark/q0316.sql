SELECT cn.name,
       count(*) c
FROM cast_info ci
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE cn.name ILIKE '%dracula%'
GROUP BY cn.name
ORDER BY c DESC
LIMIT 30;
