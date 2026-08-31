SELECT (t.production_year/10)*10 AS decade,
       trim(substr(mi.info, 5)) AS rating,
       count(*) AS n
FROM movie_info mi
JOIN title t ON t.id = mi.movie_id
WHERE mi.info_type_id = 5
  AND mi.info LIKE 'USA:%'
  AND t.production_year IS NOT NULL
GROUP BY 1,
         2 QUALIFY row_number() OVER (PARTITION BY decade
                                      ORDER BY n DESC, rating) <= 3
ORDER BY decade,
         n DESC,
         rating;
