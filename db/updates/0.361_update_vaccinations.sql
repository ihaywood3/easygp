-- this update fixes some null fields in the lu_vaccines table, and normalises the form by dropping the form field 
-- and using the lookup table for forms (lu_formulations)
-- removes the duplicate 'Yellow Fever' in the orginal lu_descriptions table
-- several records in the original database had fk_route and fk_form =null (fixed)
-- fixes some spelling mistakes in the vaccine descriptions
-- adds constraints to many of the tables

update common.lu_route_administration set abbreviation='ID' where route ='intradermal';
update clin_vaccination.lu_vaccines set fk_route=4 where pk=1 ; -- BCG Vaccine
update clin_vaccination.lu_vaccines set fk_route=2 where pk=2; -- Coxiella burnetii vaccine or q fever
update clin_vaccination.lu_vaccines set fk_route=1 where pk=42; -- plague vaccine or Yersinia pestis vaccine
update clin_vaccination.lu_vaccines set fk_form = 1 where pk=2 or pk=1 or pk=42;
update clin_vaccination.lu_descriptions set description = 'Diphtheria,Tetanus,Pertussis,HIB,Polio' where pk=8;
update clin_vaccination.lu_descriptions set description = 'Diphtheria,Tetanus,Pertussis,Polio' where pk=38;
update clin_vaccination.lu_vaccines set fk_description=9 where fk_description=27;
update clin_vaccination.lu_descriptions set deleted = True where pk=27;

 -- this was a left-over column from DeskDesk never normalised properly
 -- view clin_vaccination.vwvaccinesgiven depends on table clin_vaccination.lu_vaccines column form
-- view clin_vaccination.vwvaccinesinschedule depends on table clin_vaccination.lu_vaccines column form
alter table clin_vaccination.lu_vaccines drop column form cascade ; 


CREATE OR REPLACE VIEW clin_vaccination.vwvaccinesgiven AS 
 SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, vaccinations.fk_consult, 
 consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, 
 consult.consult_date, consult.fk_staff, 
 lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, 
 lu_schedules.atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, 
 lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, 
 lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, lu_seasons.season, 
 lu_laterality.laterality, lu_site_administration.site, lu_vaccines.brand, 
 lu_formulation.form, 
 lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive, vaccinations.fk_vaccine, 
 vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, 
 vaccinations.serial_no, vaccinations.fk_progressnote, vaccinations.not_given, 
 vaccinations.notes, vaccinations.deleted
   FROM clin_vaccination.vaccinations
   JOIN clin_consult.consult ON vaccinations.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   LEFT JOIN common.lu_site_administration ON vaccinations.fk_site = lu_site_administration.pk
   LEFT JOIN common.lu_laterality ON vaccinations.fk_laterality = lu_laterality.pk
   JOIN clin_vaccination.lu_schedules ON vaccinations.fk_schedule = lu_schedules.pk
   JOIN clin_vaccination.lu_vaccines ON vaccinations.fk_vaccine = lu_vaccines.pk
   JOIN clin_vaccination.lu_formulation on lu_vaccines.fk_form = lu_formulation.pk
   LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk;

ALTER TABLE clin_vaccination.vwvaccinesgiven   OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesgiven TO staff;

CREATE OR REPLACE VIEW clin_vaccination.vwvaccinesinschedule AS 
 SELECT lu_vaccines_in_schedule.pk AS pk_view, lu_vaccines_in_schedule.pk AS fk_lu_vaccines_in_schedule,
  lu_vaccines_in_schedule.fk_schedule, lu_vaccines_in_schedule.fk_vaccine, 
  lu_vaccines_in_schedule.atsi_only AS vaccine_atsi_only, 
  lu_vaccines_in_schedule.date_inactive AS date_vaccine_in_schedule_inactive, 
  lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, 
  lu_schedules.schedule, lu_schedules.female_only AS schedule_female_only, 
  lu_schedules.atsi_only AS schedule_atsi_only, lu_schedules.fk_season, 
  lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, 
  lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes, lu_vaccines.brand, 
  lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive AS vaccine_inactive, 
  lu_formulation.form, lu_vaccines.fk_form,
  lu_seasons.season, lu_descriptions.description AS vaccine_description
   FROM clin_vaccination.lu_vaccines_in_schedule
   JOIN clin_vaccination.lu_schedules ON lu_vaccines_in_schedule.fk_schedule = lu_schedules.pk
   JOIN clin_vaccination.lu_vaccines ON lu_vaccines_in_schedule.fk_vaccine = lu_vaccines.pk
   LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk
   JOIN clin_vaccination.lu_formulation on lu_vaccines.fk_form = lu_formulation.pk
   JOIN clin_vaccination.lu_descriptions ON lu_vaccines.fk_description = lu_descriptions.pk
  ORDER BY lu_vaccines_in_schedule.fk_schedule, lu_vaccines.brand;

ALTER TABLE clin_vaccination.vwvaccinesinschedule   OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesinschedule TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccinesinschedule TO staff;

Delete from clin_vaccination.lu_vaccines_in_schedule where fk_schedule=1 ;
Delete from clin_vaccination.lu_vaccines_in_schedule where fk_schedule=10 ;
Delete from clin_vaccination.lu_vaccines_in_schedule where fk_schedule=11 ;
Delete from clin_vaccination.lu_vaccines_in_schedule where fk_schedule=12 ;
delete from  clin_vaccination.lu_vaccines_in_schedule where fk_vaccine = 0;

alter table clin_vaccination.lu_descriptions alter column description set not null;

alter table clin_vaccination.vaccine_serial_numbers 
ADD CONSTRAINT vaccine_serial_numbers_fk_vaccine FOREIGN KEY (fk_vaccine)
      REFERENCES clin_vaccination.lu_vaccines ;

ALTER TABLE clin_vaccination.lu_vaccines_in_schedule
add CONSTRAINT lu_vaccines_in_schedule_fk_vaccine FOREIGN KEY (fk_vaccine)
      REFERENCES clin_vaccination.lu_vaccines ;


ALTER TABLE clin_vaccination.lu_vaccines_in_schedule
ADD CONSTRAINT Lu_vaccines_in_schedule_fk_schedule FOREIGN KEY (fk_schedule)
      REFERENCES clin_vaccination.lu_schedules (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

Alter table clin_vaccination.vaccinations
ADD CONSTRAINT vaccinations_fk_vaccine FOREIGN KEY (fk_vaccine)
      REFERENCES clin_vaccination.lu_vaccines (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
     
      Alter table clin_vaccination.vaccinations
ADD CONSTRAINT vaccinations_fk_schedule FOREIGN KEY (fk_schedule)
      REFERENCES clin_vaccination.lu_schedules (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


update db.lu_version set lu_minor=361;