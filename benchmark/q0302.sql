SELECT k.keyword
FROM movie_keyword mk
JOIN keyword k ON mk.keyword_id=k.id
WHERE mk.movie_id=780007
ORDER BY k.keyword;
