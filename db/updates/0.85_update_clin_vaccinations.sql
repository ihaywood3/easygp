DROP TABLE clin_vaccination.vaccinations cascade;

CREATE TABLE clin_vaccination.vaccinations
(
  pk serial primary key,
  fk_vaccine integer,
  fk_schedule integer,
  fk_site integer NOT NULL DEFAULT 1,
  fk_laterality integer,
  date_given character varying(10), -- not a date field because sometimes may need to record just say 01/2002 or 1998
  serial_no text NOT NULL DEFAULT 'not recorded'::text,
  fk_progressnote integer);

  
ALTER TABLE clin_vaccination.vaccinations OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vaccinations TO easygp;
GRANT ALL ON TABLE clin_vaccination.vaccinations TO staff;
COMMENT ON COLUMN clin_vaccination.vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


CREATE OR REPLACE VIEW clin_vaccination.vwvaccinesgiven AS 
 SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, consult.consult_date, consult.fk_staff, consult.pk AS fk_consult, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, lu_schedules.atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, lu_seasons.season, lu_laterality.laterality, lu_site_administration.site, progressnotes.notes AS progress_notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive, vaccinations.fk_vaccine, vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, vaccinations.serial_no, vaccinations.fk_progressnote
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_consult.progressnotes ON progressnotes.fk_consult = consult.pk
   JOIN clin_vaccination.vaccinations ON vaccinations.fk_progressnote = progressnotes.pk
   LEFT JOIN common.lu_site_administration ON vaccinations.fk_site = lu_site_administration.pk
   LEFT JOIN common.lu_laterality ON vaccinations.fk_laterality = lu_laterality.pk
   JOIN clin_vaccination.lu_schedules ON vaccinations.fk_schedule = lu_schedules.pk
   JOIN clin_vaccination.lu_vaccines ON vaccinations.fk_vaccine = lu_vaccines.pk
   LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk
  ORDER BY consult.fk_patient, vaccinations.fk_schedule, vaccinations.date_given;

ALTER TABLE clin_vaccination.vwvaccinesgiven OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 85);

