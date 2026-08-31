SELECT info
FROM movie_info
WHERE info_type_id=5
  AND info ILIKE 'USA:%'
LIMIT 30;
