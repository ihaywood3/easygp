-- fixes missing loincs for hepatitis A/B serology

update documents.observations set loinc = '20575-7' where identifier ILIKE 'hepatitis a igg'and loinc is null;
update documents.observations set loinc = '75409-3' where identifier ILIKE 'hepatitis B Surface Ab'and loinc is null;

--select * from documents.observations where identifier ILIKE 'hepatitis a igg'and loinc is null;
-- select * from documents.observations where identifier ILIKE  'hepatitis B Surface Ab'and loinc is null;

update db.lu_version set lu_minor=515;