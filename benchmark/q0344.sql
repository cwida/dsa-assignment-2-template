SELECT (production_year/10)*10 AS decade,
       count(*)
FROM
  (SELECT DISTINCT t.id,
                   t.production_year
   FROM movie_companies mc
   JOIN title t ON t.id = mc.movie_id
   WHERE mc.company_id IN (35376,
                           15812,
                           54516,
                           50752,
                           154575,
                           233196))
GROUP BY 1
ORDER BY 1;
