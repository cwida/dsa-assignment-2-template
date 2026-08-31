SELECT id,
       title,
       production_year,
       kind_id
FROM title
WHERE title ILIKE '%fabuleux destin%amelie%'
  OR title ILIKE '%fabuleux destin%amélie%';
