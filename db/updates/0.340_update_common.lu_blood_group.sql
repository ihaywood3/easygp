-- changed abo_group type from char(2) to text as postges pads the field with ascii 32
-- drops view pregnancies which will be rebuilt in 0.341_update_pregnancy.sql

DROP VIEW clin_pregnancy.vwpregnancies;
alter table common.lu_blood_group alter column abo_group type text;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 340);


