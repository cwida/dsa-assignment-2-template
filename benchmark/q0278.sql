SELECT mi.info AS country,
       count(DISTINCT ci.movie_id) AS n_films
FROM cast_info ci
JOIN movie_info mi ON mi.movie_id = ci.movie_id
AND mi.info_type_id = 8
WHERE ci.person_id = 816165
GROUP BY mi.info
ORDER BY n_films DESC;
