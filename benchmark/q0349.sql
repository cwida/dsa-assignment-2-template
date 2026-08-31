SELECT country_code,
       count(*)
FROM company_name
GROUP BY country_code
ORDER BY 2 DESC
LIMIT 20;
