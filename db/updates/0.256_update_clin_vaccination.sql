COMMENT ON COLUMN clin_vaccination.vaccinations.fk_site IS
 'foreign key for common.lu_route_administrations.
  As sometimes we need to record a vaccine component as not given 
  for example when a child is having a catch up schedule then
  fk_site is 0';

alter table clin_vaccination.vaccinations alter column fk_laterality set default 0;
COMMENT ON COLUMN clin_vaccination.vaccinations.fk_laterality is
'if not 0 is the key to common.lu_laterality';

-- insert new field, will put in contstraint once populated
alter table clin_vaccination.vaccinations add column fk_consult integer;

-- temporary function to fill clin_vaccination.fk_consult field
CREATE OR REPLACE FUNCTION clin_vaccination.fix_fk_consult(integer)
  RETURNS integer AS
$BODY$
declare
 i integer;
begin
   select into i fk_consult from clin_consult.progressnotes where pk = $1;
 RETURN i;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;

UPDATE clin_vaccination.vaccinations set fk_consult= clin_vaccination.fix_fk_consult(fk_progressnote);
alter table clin_vaccination.vaccinations add constraint "vaccinations_fk_consult" foreign key (fk_consult) references clin_consult.consult(pk);
alter table clin_vaccination.vaccinations alter column fk_consult set not null;
drop function clin_vaccination.fix_fk_consult(integer);
-- the new vaccines given query
DROP VIEW clin_vaccination.vwvaccinesgiven;

CREATE OR REPLACE VIEW clin_vaccination.vwvaccinesgiven AS 
 SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, vaccinations.fk_consult,
consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, 
consult.consult_date, consult.fk_staff, 
lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, 
lu_schedules.schedule, lu_schedules.female_only, lu_schedules.atsi_only, 
lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, 
lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, 
lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, 
lu_seasons.season, lu_laterality.laterality, lu_site_administration.site, 
lu_vaccines.brand, 
lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, 
lu_vaccines.inactive, vaccinations.fk_vaccine, vaccinations.fk_schedule, 
vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, 
vaccinations.serial_no, vaccinations.fk_progressnote, vaccinations.not_given, 
vaccinations.notes, vaccinations.deleted
   FROM clin_vaccination.vaccinations
   JOIN clin_consult.consult on vaccinations.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   LEFT JOIN common.lu_site_administration ON vaccinations.fk_site = lu_site_administration.pk
   LEFT JOIN common.lu_laterality ON vaccinations.fk_laterality = lu_laterality.pk
   JOIN clin_vaccination.lu_schedules ON vaccinations.fk_schedule = lu_schedules.pk
   JOIN clin_vaccination.lu_vaccines ON vaccinations.fk_vaccine = lu_vaccines.pk
   LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk;

ALTER TABLE clin_vaccination.vwvaccinesgiven OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO staff;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO easygp;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 256);

