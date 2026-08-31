SELECT count(*)
FROM
  (SELECT person_id
   FROM aka_name
   GROUP BY person_id
   HAVING count(*) >= 1) t;
