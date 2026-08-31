SELECT string_agg(k.keyword, ', ' ORDER BY k.keyword)
FROM movie_keyword mk
JOIN keyword k ON mk.keyword_id=k.id
WHERE mk.movie_id=2058736;
