update clin_consult.lu_progressnotes_sections set section ='staff tasks' where pk=13;

update clin_consult.lu_consult_type set type = 'Audit' where pk=11;

--richard = you are working on database easygp-home-07Dec10

alter table clerical.tasks drop column fk_schema cascade;
alter table clerical.tasks drop column fk_table;
Alter table clerical.task_components drop column fk_lu_task_type;
-- cascades to clerical.vwtaskscomponents
--clerical.vwtaskscomponent_new
--clerical.vwtaskscomponentsandnotes


CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task,  tasks.fk_row, 
 tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, 
 vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
 vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
 task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
 task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, 
 task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, 
 task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename,
 vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged,
  vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode,
   vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, 
   vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate,
   lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponents_new AS 
 SELECT tasks.task, tasks.fk_staff_filed_task, tasks.fk_staff_finalised_task, 
  tasks.fk_row, tasks.date_finalised, tasks.deleted AS task_deleted, task_components.pk AS pk_view,
   task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult,
    task_components.date_logged, task_components.fk_staff_allocated,
     task_components.fk_staff_completed, task_components.allocated_staff, 
     task_components.fk_urgency, task_components.details,
      task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted,
       vwstaffinclinics.wholename AS staff_filed_task_wholename, 
       vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics1.wholename AS staff_finalised_task_wholname,
        vwstaffinclinics1.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_allocated_wholename,
         vwstaffinclinics2.title AS staff_allocated_title, vwstaffinclinics3.wholename AS staff_completed_component_wholename,
          vwstaffinclinics3.title AS staff_completed_component_title, consult.consult_date AS date_component_logged,
           lu_urgency.urgency, vwstaff.fk_staff AS fk_staff_filed_component, 
           vwstaff.wholename AS staff_filed_component_wholename, vwstaff.title AS staff_filed_component_title,
            vwpatients.wholename AS patient_wholename, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname,
             vwpatients.birthdate AS patient_birthdate, vwpatients.fk_sex, vwpatients.fk_title AS patient_fk_title, 
             vwpatients.title AS patient_title, vwpatients.street AS patient_street, vwpatients.town AS patient_town,
              vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.fk_person,
               vwpatients.fk_patient, vwpatients.age AS patient_age
   FROM clerical.tasks
   JOIN clerical.task_components ON tasks.pk = task_components.fk_task
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON tasks.fk_staff_finalised_task = vwstaffinclinics1.fk_staff
   JOIN admin.vwstaffinclinics vwstaffinclinics2 ON task_components.fk_staff_allocated = vwstaffinclinics2.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON task_components.fk_staff_completed = vwstaffinclinics3.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents_new OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents_new TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents_new TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.task,  task_components.details,
         task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task,
          tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename,
           vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, 
           vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.fk_role, task_components.pk AS fk_component,
            task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated,
             task_components.fk_staff_completed, task_components.allocated_staff, 
           task_components.fk_urgency, task_components.date_completed AS date_component_completed,
            task_components.deleted AS component_deleted,
             vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title,
              consult.consult_date AS date_component_logged, vwpatients.town AS patient_town,
               vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode,
                vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient,
                 vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, 
                 vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency,
                  task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, 
                  task_component_notes.fk_staff_made_note
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes OWNER TO easygp;

GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO staff;




truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 53)