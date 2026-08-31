SELECT k.kind,
       count(*) n
FROM movie_info mi
JOIN title t ON t.id = mi.movie_id
JOIN kind_type k ON k.id = t.kind_id
WHERE mi.info_type_id=5
  AND mi.info LIKE 'USA:X%'
  AND t.production_year BETWEEN 2000 AND 2009
GROUP BY 1
ORDER BY n DESC;
