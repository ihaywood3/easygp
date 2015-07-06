 -- bug in importing HL7 meant no loinc code put into egfr where value >maximum range value
update documents.observations set loinc='33914-3' where identifier ilike 'egfr' and loinc is null;
update db.lu_version set lu_minor=402;