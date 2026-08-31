SELECT id,
       movie_id,
       title,
       production_year
FROM aka_title
WHERE title ILIKE '%amelie%'
  OR title ILIKE '%amélie%';
