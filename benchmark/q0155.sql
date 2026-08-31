WITH all_names AS
  (SELECT person_id,
          name
   FROM aka_name
   UNION SELECT id AS person_id,
                name
   FROM name
   WHERE id IN
       (SELECT DISTINCT person_id
        FROM aka_name)),
     per_person AS
  (SELECT person_id,
          count(DISTINCT name) AS n_names
   FROM all_names
   GROUP BY person_id)
SELECT count(*) AS people_multi_name
FROM per_person
WHERE n_names > 1;
