SELECT id,
       title,
       production_year,
       kind_id
FROM title
WHERE title ILIKE '%amelie%'
  OR title ILIKE '%amélie%'
  OR title ILIKE '%fabuleux destin%';
