SELECT ct.kind AS company_role,
       count(*)
FROM movie_companies mc
JOIN company_name cn ON cn.id = mc.company_id
JOIN company_type ct ON ct.id = mc.company_type_id
WHERE cn.id IN (35376,
                15812,
                54516,
                50752,
                154575,
                233196)
GROUP BY 1;
