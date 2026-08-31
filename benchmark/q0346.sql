SELECT t.title,
       t.production_year
FROM movie_companies mc
JOIN title t ON t.id = mc.movie_id
WHERE mc.company_id IN (35376,
                        15812,
                        54516,
                        50752,
                        154575,
                        233196)
ORDER BY t.production_year DESC
LIMIT 10;
