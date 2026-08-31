SELECT mi.info AS genre, count(*) AS n_titles
FROM title t
JOIN kind_type kt ON kt.id = t.kind_id
JOIN movie_info mi ON mi.movie_id = t.id
JOIN info_type it ON it.id = mi.info_type_id
WHERE t.production_year BETWEEN 2008 AND 2013
  AND kt.kind IN ('episode', 'movie', 'video movie', 'tv movie', 'tv series', 'video game')
  AND it.info = 'genres'
GROUP BY mi.info
ORDER BY n_titles DESC, genre
LIMIT 15;
