SELECT count(*)
FROM
  (SELECT mc1.company_id,
          mc2.company_id
   FROM movie_companies mc1
   JOIN movie_companies mc2 ON mc1.movie_id = mc2.movie_id
   AND mc1.company_id < mc2.company_id
   JOIN title t ON t.id = mc1.movie_id
   WHERE t.production_year BETWEEN 1990 AND 2010
     AND mc1.company_type_id = 2
     AND mc2.company_type_id = 2
   GROUP BY mc1.company_id,
            mc2.company_id
   HAVING count(*) >= 20);
