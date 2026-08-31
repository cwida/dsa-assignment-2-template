SELECT t.kind_id,
       k.kind,
       count(*)
FROM movie_companies mc
JOIN title t ON t.id = mc.movie_id
JOIN kind_type k ON k.id = t.kind_id
WHERE mc.company_id IN (35376,
                        15812,
                        54516,
                        50752,
                        154575,
                        233196)
GROUP BY 1,
         2
ORDER BY 3 DESC;
