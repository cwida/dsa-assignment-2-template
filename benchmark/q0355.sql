SELECT mi.info AS genre,
       count(DISTINCT ci.movie_id) AS n
FROM cast_info ci
JOIN movie_info mi ON mi.movie_id = ci.movie_id
AND mi.info_type_id=3
WHERE ci.person_id = 179356
GROUP BY mi.info
ORDER BY n DESC;
