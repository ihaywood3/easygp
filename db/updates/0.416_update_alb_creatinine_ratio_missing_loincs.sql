-- bug in importing HL7 meant no loinc code put into R U-Albumin/Creat where value < range value
-- this was an old bug, not specific to a/c ratio which was fixed a long time ago, but the backend wasn't 

update documents.observations set loinc='14959-1' where identifier ilike 'R U-Albumin/Creat' and loinc is null;

update db.lu_version set lu_minor=416;