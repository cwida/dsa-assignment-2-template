SELECT CAST(t.production_year/10 AS INT)*10 AS decade,
       count(*) c
FROM movie_companies mc
JOIN title t ON t.id = mc.movie_id
WHERE mc.company_id IN (35376,
                        15812,
                        54516,
                        50752,
                        154575,
                        233196)
  AND t.production_year IS NOT NULL
GROUP BY 1
ORDER BY 1;
