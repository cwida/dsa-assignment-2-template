SELECT id,
       info
FROM info_type
WHERE info ILIKE '%certif%'
  OR info ILIKE '%rating%';
