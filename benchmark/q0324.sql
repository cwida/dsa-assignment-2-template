SELECT id,
       name
FROM name
WHERE name ILIKE '%depardieu%gerard%'
  OR name ILIKE '%gerard%depardieu%';
