WITH depmovies AS
  (SELECT DISTINCT movie_id
   FROM cast_info
   WHERE person_id=385107),
     prod AS
  (SELECT mc.movie_id,
          cn.country_code
   FROM movie_companies mc
   JOIN company_name cn ON cn.id = mc.company_id
   WHERE mc.company_type_id = 2
     AND mc.movie_id IN
       (SELECT movie_id
        FROM depmovies))
SELECT movie_id,
       count(DISTINCT country_code) FILTER (
                                            WHERE country_code IS NOT NULL) AS n_countries,
       list(DISTINCT country_code) AS countries
FROM prod
GROUP BY movie_id
HAVING bool_or(country_code = '[fr]')
AND bool_or(country_code IS DISTINCT
            FROM '[fr]'
            AND country_code IS NOT NULL);
