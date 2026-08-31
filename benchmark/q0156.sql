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
SELECT p.person_id,
       n.name,
       p.n_names
FROM per_person p
JOIN name n ON n.id = p.person_id
ORDER BY p.n_names DESC
LIMIT 10;
