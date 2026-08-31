SELECT it.info AS field,
       mi.info AS value
FROM movie_info mi
JOIN info_type it ON mi.info_type_id=it.id
WHERE mi.movie_id=2058736
  AND it.info IN ('genres',
                  'countries',
                  'languages');
