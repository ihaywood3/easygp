ALTER TABLE clin_vaccination.vaccinations add column fk_consult integer not null;
ALTER TABLE clin_vaccination.vaccinations ADD  CONSTRAINT
      vaccinations_fk_consult FOREIGN KEY (fk_consult)
      REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- View: clin_vaccination.vwvaccinesgiven

DROP VIEW clin_vaccination.vwvaccinesgiven;

CREATE OR REPLACE VIEW clin_vaccination.vwvaccinesgiven AS 
 SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, 
 vaccinations.fk_consult, consult.fk_patient, vwstaff.title AS staff_title, 
 vwstaff.wholename AS staff_wholename, consult.consult_date, consult.fk_staff, 
 lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, 
 lu_schedules.female_only, lu_schedules.atsi_only, lu_schedules.fk_season, 
 lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, 
 lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, 
 lu_seasons.season, lu_laterality.laterality, lu_site_administration.site, lu_vaccines.brand, lu_vaccines.form, 
 lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive, vaccinations.fk_vaccine, 
 vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, 
 vaccinations.serial_no, vaccinations.fk_progressnote, vaccinations.not_given, vaccinations.notes, vaccinations.deleted
   FROM clin_vaccination.vaccinations
   JOIN clin_consult.consult ON vaccinations.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   LEFT JOIN common.lu_site_administration ON vaccinations.fk_site = lu_site_administration.pk
   LEFT JOIN common.lu_laterality ON vaccinations.fk_laterality = lu_laterality.pk
   JOIN clin_vaccination.lu_schedules ON vaccinations.fk_schedule = lu_schedules.pk
   JOIN clin_vaccination.lu_vaccines ON vaccinations.fk_vaccine = lu_vaccines.pk
   LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk;

ALTER TABLE clin_vaccination.vwvaccinesgiven   OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 279);

