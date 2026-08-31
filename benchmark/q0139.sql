SELECT k.keyword, count(*) AS n_titles
FROM title t
JOIN kind_type kt ON kt.id = t.kind_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE t.production_year BETWEEN 2003 AND 2009
  AND kt.kind IN ('episode', 'movie')
GROUP BY k.keyword
ORDER BY n_titles DESC, k.keyword
LIMIT 25;
