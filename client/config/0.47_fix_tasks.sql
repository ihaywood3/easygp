-- don't try and use this not complete

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_schema, tasks.fk_table, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_lu_task_type, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_task_types.type AS task_type, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN clerical.lu_task_types ON task_components.fk_lu_task_type = lu_task_types.pk
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TOeasygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponentsnotes AS 
 SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename, vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task
   FROM clerical.task_component_notes
   JOIN admin.vwstaffinclinics ON task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff
   JOIN clerical.task_components ON task_component_notes.fk_task_component = task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsnotes OWNER TO  easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO staff;
