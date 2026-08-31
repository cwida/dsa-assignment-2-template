SELECT t.kind_id,
       kt.kind,
       count(*)
FROM cast_info ci
JOIN title t ON t.id = ci.movie_id
JOIN kind_type kt ON kt.id = t.kind_id
WHERE ci.person_id = 179356
GROUP BY t.kind_id,
         kt.kind
ORDER BY 3 DESC;
