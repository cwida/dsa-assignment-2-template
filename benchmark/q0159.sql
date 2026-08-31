SELECT trim(substr(mi.info, 5)) AS rating,
       count(*) AS n
FROM movie_info mi
WHERE mi.info_type_id = 5
  AND mi.info LIKE 'USA:%'
GROUP BY 1
ORDER BY n DESC
LIMIT 20;
