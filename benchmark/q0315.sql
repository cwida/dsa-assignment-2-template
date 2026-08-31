SELECT id,
       name
FROM char_name
WHERE name ILIKE '%dracula%'
ORDER BY name
LIMIT 200
OFFSET 60;
