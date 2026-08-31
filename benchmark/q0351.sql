SELECT count(DISTINCT movie_id)
FROM movie_info
WHERE info_type_id=8
  AND info='India';
