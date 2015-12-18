-- changes to defaults form some fields, add constraints


alter table  clin_vaccination.vaccinations alter column fk_laterality set default null;
update clin_vaccination.vaccinations set fk_laterality = null where fk_laterality = 0;
update clin_vaccination.vaccinations set fk_site = 10 where fk_site = 0;-- 'unknown'= 10
ALTER TABLE clin_vaccination.vaccinations ADD COLUMN fk_site_new  integer default null;
update clin_vaccination.vaccinations set fk_site_new  = fk_site where fk_site > 0;
alter table clin_vaccination.vaccinations drop column fk_site cascade;
alter table clin_vaccination.vaccinations rename fk_site_new to fk_site;


COMMENT ON COLUMN clin_vaccination.vaccinations.fk_laterality IS 
'if not null is the key to common.lu_laterality, there may be many null''s e.g with imported vaccination data';
COMMENT ON COLUMN clin_vaccination.vaccinations.fk_site IS 'foreign key for common.lu_site_administrations.
  As sometimes we need to record a vaccine component as not given 
  for example when a child is having a catch up schedule then
  fk_site  will be null';

CREATE OR REPLACE VIEW clin_vaccination.vwvaccinesgiven AS 
 SELECT vaccinations.pk AS pk_view,
    vaccinations.pk AS fk_vaccination,
    vaccinations.fk_consult,
    consult.fk_patient,
    vwstaff.title AS staff_title,
    vwstaff.wholename AS staff_wholename,
    consult.consult_date,
    consult.fk_staff,
    lu_schedules.age_due_from_months,
    lu_schedules.age_due_to_months,
    lu_schedules.schedule,
    lu_schedules.female_only,
    lu_schedules.atsi_only,
    lu_schedules.fk_season,
    lu_schedules.inactive AS schedule_inactive,
    lu_schedules.date_inactive AS date_schedule_inactive,
    lu_schedules.deleted AS schedule_deleted,
    lu_schedules.multiple_vaccines,
    lu_schedules.notes AS schedule_notes,
    lu_seasons.season,
    lu_laterality.laterality,
    lu_site_administration.site,
    lu_vaccines.brand,
    lu_formulation.form,
    lu_vaccines.fk_description,
    lu_vaccines.fk_route,
    lu_vaccines.inactive,
    vaccinations.fk_vaccine,
    vaccinations.fk_schedule,
    vaccinations.fk_site,
    vaccinations.fk_laterality,
    vaccinations.date_given,
    vaccinations.serial_no,
    vaccinations.fk_progressnote,
    vaccinations.not_given,
    vaccinations.notes,
    vaccinations.deleted
   FROM clin_vaccination.vaccinations
     JOIN clin_consult.consult ON vaccinations.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     LEFT JOIN common.lu_site_administration ON vaccinations.fk_site = lu_site_administration.pk
     LEFT JOIN common.lu_laterality ON vaccinations.fk_laterality = lu_laterality.pk
     JOIN clin_vaccination.lu_schedules ON vaccinations.fk_schedule = lu_schedules.pk
     JOIN clin_vaccination.lu_vaccines ON vaccinations.fk_vaccine = lu_vaccines.pk
     JOIN clin_vaccination.lu_formulation ON lu_vaccines.fk_form = lu_formulation.pk
     LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk;

ALTER TABLE clin_vaccination.vwvaccinesgiven   OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO staff;

  
  
  
update db.lu_version set lu_minor = 449;