SELECT id,
       name
FROM name
WHERE name ILIKE '%Kieslowski%Krzysztof%'
  OR name ILIKE '%Krzysztof%Kieslowski%';
