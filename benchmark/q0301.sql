SELECT it.info,
       mi.info
FROM movie_info mi
JOIN info_type it ON mi.info_type_id=it.id
WHERE mi.movie_id=780007
  AND it.info IN ('genres',
                  'countries',
                  'languages');
