SELECT kt.kind,
       COUNT(*)
FROM cast_info ci
JOIN title t ON t.id=ci.movie_id
JOIN kind_type kt ON kt.id=t.kind_id
WHERE ci.person_id=809234
  AND ci.role_id=8
GROUP BY kt.kind;
